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
    //
    let field_historyTypeId = "historyTypeId"
    let field_historyType = "historyType"
    let field_historyText = "historyText"
    let field_timeStamp = "timeStamp"
    let tbl_history = "otherHistory"
    
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
    //MARK:- History
    func createTableOtherHistory() -> Bool {
        var created = false
        
        if FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    
                    //let createhistoryTableQuery = "CREATE TABLE IF NOT EXISTS \(tbl_history) (\(field_historyTypeId) integer not null, \(field_historyType) TEXT not null,\(field_historyText) TEXT, \(field_timeStamp) NUMERIC NOT NULL)"
                    let createhistoryTableQuery = """
                    CREATE TABLE IF NOT EXISTS "\(tbl_history)" (
                        "\(field_historyTypeId)"    integer NOT NULL,
                        "\(field_historyType)"    TEXT NOT NULL,
                        "\(field_historyText)"    TEXT,
                        "\(field_timeStamp)"    NUMERIC NOT NULL
                    );
                    """
                    do {
                        try database.executeUpdate(createhistoryTableQuery, values: nil)
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
    
    func insertHistoryData(model:HistoryDataDisplayModel,completionHandler: (_ success:Bool,_ error:Error?) -> Void) {
        if openDatabase() {
            
            do {
                
                var query = ""
                guard (model.id != nil),let id = model.id?.rawValue, let name = model.name?.rawValue, let type = model.txtValue, let timeStamp = model.timeStamp   else {
                    database.close()
                    return
                }
                
                query = "INSERT INTO \(tbl_history) (\(field_historyTypeId),\(field_historyType),\(field_historyText),\(field_timeStamp)) VALUES (\(id),'\(name)','\(type)',\(timeStamp)) ;"
                
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError() ?? NSError(), database.lastErrorMessage() as Any)
                    completionHandler(false,database.lastError())
                }
                completionHandler(true,nil)
            }
            
            
            database.close()
        }
    }
    
    
    func loadHistories() -> [HistoryDataDisplayModel]! {
        var arrHistory: [HistoryDataDisplayModel]!
        
        if openDatabase() {
            let query = "SELECT * FROM \(tbl_history)"
            
            do {
                
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let historyData = prepareHistoryModelFromResult(results: results)
                    if arrHistory == nil{
                        arrHistory = [HistoryDataDisplayModel]()
                    }
                    arrHistory.append(historyData)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return arrHistory
    }
    
    func prepareHistoryModelFromResult(results:FMResultSet)->HistoryDataDisplayModel{
        
        let historyTypeId = Int((results.int(forColumn: field_historyTypeId)))
        let historyType = results.string(forColumn: field_historyType)
        let historyText = results.string(forColumn: field_historyText)
        let timeStamp = results.double(forColumn: field_timeStamp)
        let historyData = HistoryDataDisplayModel(id: OtherHistoryId(rawValue: historyTypeId)!, name: OtherHistory(rawValue: historyType  ?? "none")!, txtValue: historyText ?? "", timeStamp: timeStamp )
        
        return historyData
    }
    
    func loadHisory(withID ID: Int, completionHandler: (_ success:Bool,_ conditionInfo: HistoryDataDisplayModel?) -> Void) {
        if openDatabase() {
            let query = "SELECT * FROM \(tbl_history) WHERE  \(field_historyTypeId)=?"
            
            do {
                let results = try database.executeQuery(query, values: [ID])
                
                if results.next() {
                    let history = prepareHistoryModelFromResult(results: results)
                    completionHandler(true,history)
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
    
    func deleteHistory(model:HistoryDataDisplayModel) -> Bool {
        var deleted = false
        guard let timeStamp = model.timeStamp   else {
            database.close()
            return false;
        }
        if openDatabase() {
            let query = "DELETE from \(tbl_history) where \(field_timeStamp)=?"
            
            do {
                try database.executeUpdate(query, values: [timeStamp])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }
    
    //MARK:- Condition
    func insertConditionData(completionHandler: (_ success:Bool,_ error:Error?) -> Void) {
        if openDatabase() {
            
            do {
                
                var query = ""
                for conditionTitle in ConditionType.allCases {
                    if conditionTitle != ConditionType(rawValue: ""){
                        print("conditionTitle--->",conditionTitle)
                        //Here is first select condition, if it's not exist insert into database, so duplicate entry can't be done.
                        query += "insert into conditions (\(field_ConditionName)) SELECT ('\(conditionTitle.rawValue)') WHERE not exists (select * from conditions where (\(field_ConditionName)) = ('\(conditionTitle.rawValue)'));"
                    }
                }
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError() ?? NSError(), database.lastErrorMessage() as Any)
                    completionHandler(false,database.lastError())
                }
                completionHandler(true,nil)
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
