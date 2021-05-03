//
//  DBManager.swift
//  FMDBTut
//
//  Created by Gabriel Theodoropoulos on 07/10/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    let field_ConditionID = "id"
    let field_ConditionName = "name"
    let field_ConditionIsSelected = "isSelected"
    
    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "AcuityEngine.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func copyfileToUserDocumentDirectory(forResource name: String,
                                         ofType ext: String) throws
    {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
           let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                              .userDomainMask,
                                                              true).first {
            let fileName = "\(name).\(ext)"
            let fullDestPath = URL(fileURLWithPath: destPath)
                .appendingPathComponent(fileName)
            let fullDestPathString = fullDestPath.path
            pathToDatabase = fullDestPathString
            if !FileManager.default.fileExists(atPath: fullDestPathString) {
                try FileManager.default.copyItem(atPath: bundlePath, toPath: fullDestPathString)
            }
        }
    }
    /*
     func createDatabase() -> Bool {
     var created = false
     
     if !FileManager.default.fileExists(atPath: pathToDatabase) {
     database = FMDatabase(path: pathToDatabase!)
     
     if database != nil {
     // Open the database.
     if database.open() {
     let createConditionsTableQuery = "create table conditions (\(field_ConditionID) integer primary key autoincrement not null, \(field_ConditionTitle) text not null, \(field_ConditionCategory) text not null, \(field_ConditionYear) integer not null, \(field_ConditionURL) text, \(field_ConditionCoverURL) text not null, \(field_ConditionWatched) bool not null default 0, \(field_ConditionLikes) integer not null)"
     
     do {
     try database.executeUpdate(createConditionsTableQuery, values: nil)
     created = true
     }
     catch {
     print("Could not create table.")
     print(error.localizedDescription)
     }
     
     database.close()
     }
     else {
     print("Could not open the database.")
     }
     }
     }
     
     return created
     }
     */
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase!)
            }else{
                do{
                    try copyfileToUserDocumentDirectory(forResource: "AcuityEngine", ofType: "sqlite")
                    database = FMDatabase(path: pathToDatabase!)
                }
                catch{
                    
                }
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    
    func insertConditionData(completionHandler: (_ success:Bool,_ error:Error?) -> Void) {
        if openDatabase() {
            if let pathToConditionsFile = Bundle.main.path(forResource: "Conditions", ofType: "txt") {
                do {
                    let conditionsFileContents = try String(contentsOfFile: pathToConditionsFile)
                    
                    let conditionsData = conditionsFileContents.components(separatedBy: "\n")
                    
                    var query = ""
                    for conditionTitle in ConditionType.allCases {
                        if conditionTitle != ConditionType(rawValue: ""){
                            print("conditionTitle--->",conditionTitle)
                            query += "insert into conditions (\(field_ConditionName)) values ('\(conditionTitle.rawValue)');"
                        }
                    }
                    
                    if !database.executeStatements(query) {
                        print("Failed to insert initial data into the database.")
                        print(database.lastError() ?? NSError(), database.lastErrorMessage() as Any)
                        completionHandler(false,database.lastError())
                    }
                    completionHandler(true,nil)
                }
                catch {
                    print(error.localizedDescription)
                    completionHandler(false,error)
                }
            }
            
            database.close()
        }
    }
    
    
    func loadConditions() -> [ConditionsModel]! {
        var conditions: [ConditionsModel]!
        
        if openDatabase() {
            let query = "select * from conditions order by \(field_ConditionName) asc"
            
            do {
                
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let condition = prepareConditionModelFromResult(results: results)
                    if conditions == nil{
                        conditions = [ConditionsModel]()
                    }
                    conditions.append(condition)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return conditions
    }
    
    func loadOnConditionsOnly() -> [ConditionsModel]! {
        var conditions: [ConditionsModel]!
        
        if openDatabase() {
            let query = "select * from conditions where \(field_ConditionIsSelected)=?"
            
            do {
                
                let results = try database.executeQuery(query, values: [1])
                
                while results.next() {
                    let condition = prepareConditionModelFromResult(results: results)
                    if conditions == nil{
                        conditions = [ConditionsModel]()
                    }
                    conditions.append(condition)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return conditions
    }
    
    func prepareConditionModelFromResult(results:FMResultSet)->ConditionsModel{
        var isSelected = 0
        isSelected =  Int((results.int(forColumn: field_ConditionIsSelected)))
        let conditionId = Int((results.int(forColumn: field_ConditionID)))
        let conditionName = results.string(forColumn: field_ConditionName)
        let condition = ConditionsModel(title: conditionName ?? "", value:ConditionValue(rawValue: Double(isSelected))!, conditionId: conditionId)
        
        return condition
    }
    
    func loadCondition(withID ID: Int, completionHandler: (_ success:Bool,_ conditionInfo: ConditionsModel?) -> Void) {
        var conditionInfo: ConditionsModel!
        
        if openDatabase() {
            let query = "select * from conditions where \(field_ConditionID)=?"
            
            do {
                let results = try database.executeQuery(query, values: [ID])
                
                if results.next() {
                    let condition = prepareConditionModelFromResult(results: results)
                    completionHandler(true,condition)
                }
                else {
                    print(database.lastError() as Any)
                    completionHandler(false,nil)
                }
            }
            catch {
                print(error.localizedDescription)
                completionHandler(false,nil)
            }
            
            database.close()
        }
        
        
    }
    
    
    func updateCondition(withID ID: Int, isSelected: Bool) {
        if openDatabase() {
            let query = "update conditions set \(field_ConditionIsSelected)=? where \(field_ConditionID)=?"
            
            do {
                try database.executeUpdate(query, values: [isSelected, ID])
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
    }
    
    
    func deleteCondition(withID ID: Int) -> Bool {
        var deleted = false
        
        if openDatabase() {
            let query = "delete from conditions where \(field_ConditionID)=?"
            
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }
    
}
