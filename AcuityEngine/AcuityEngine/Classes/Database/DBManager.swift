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
    let tbl_conditions = "conditions"
    //
    let field_historyTypeId = "historyTypeId"
    let field_historyType = "historyType"
    let field_historyText = "historyText"
    let field_timeStamp = "timeStamp"
    let tbl_history = "otherHistory"
    //
    let field_medicationTypeId = "medicationTypeId"
    let field_medicationType = "medicationType"
    let field_medicationText = "medicationText"
    let tbl_medication = "medications"
    
    
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
    //MARK: Fetch Data
    func fetchResultSet(query:String,values:[Any],completionHandler: (_ success:Bool,_ results:FMResultSet) -> Void){
        
        if openDatabase() {
            do {
                if values.count == 0{
                    let results = try database.executeQuery(query, values: values)
                    completionHandler(true,results)
                }else{
                    let results = try database.executeQuery(query, values: values)
                    completionHandler(true,results)
                }
                
                
            }
            catch {
                print(error.localizedDescription)
                completionHandler(false,FMResultSet())
            }
            
            database.close()
        }
        
        
    }
    //MARK: Update Data
    func updateResultSet(query:String,values:[Any],completionHandler: (_ success:Bool,_ error:Error?) -> Void){
        
        if openDatabase() {
            do {
                if values.count == 0{
                    try database.executeUpdate(query, values: nil)
                    completionHandler(true,nil)
                }else{
                    try database.executeUpdate(query, values: values)
                    completionHandler(true,nil)
                }
                
                
            }
            catch {
                print(error.localizedDescription)
                completionHandler(false,error)
            }
            
            database.close()
        }
        
        
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
        
        let query = "SELECT * FROM \(tbl_history)"
        
        do {
            
            self.fetchResultSet(query: query, values: [], completionHandler: { (success, results:FMResultSet) in
                if success{
                    while results.next()  {
                        
                        let historyData = prepareHistoryModelFromResult(results: results)
                        if arrHistory == nil{
                            arrHistory = [HistoryDataDisplayModel]()
                        }
                        arrHistory.append(historyData)
                    }
                }
            })
            
            
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
    
    func loadHisory(withID ID: Int, completionHandler: (_ success:Bool,_ historyInfo: [HistoryDataDisplayModel]?) -> Void) {
        var historyInfo:[HistoryDataDisplayModel] = []
        
        let query = "SELECT * FROM \(tbl_history) WHERE  \(field_historyTypeId)=?"
        
        do {
            
            self.fetchResultSet(query: query, values: [ID], completionHandler: { (success, results:FMResultSet) in
                if success{
                    while results.next()  {
                        
                        let historyData = prepareHistoryModelFromResult(results: results)
                        historyInfo.append(historyData)
                        
                    }
                    
                    completionHandler(true,historyInfo)
                }else{
                    
                    completionHandler(false,historyInfo)
                }
            })
            
        }
        
        
    }
    
    func deleteHistory(model:HistoryDataDisplayModel) -> Bool {
        var deleted = false
        guard let timeStamp = model.timeStamp   else {
            database.close()
            return false;
        }
        
        let query = "DELETE from \(tbl_history) where \(field_timeStamp)=?"
        
        do {
            updateResultSet(query: query, values: [timeStamp]) {(success,error) in
                if success{
                    deleted = true
                }
            }
            
        }
        
        return deleted
    }
    //========================================================================================================
    //MARK: Medication..
    //========================================================================================================
  
    func insertMedicationData(model:MedicationDataDisplayModel,completionHandler: (_ success:Bool,_ error:Error?) -> Void) {
        if openDatabase() {
            
            do {
                
                var query = ""
                guard (model.id != nil),let id = model.id?.rawValue, let name = model.name?.rawValue, let type = model.txtValue, let timeStamp = model.timeStamp   else {
                    database.close()
                    return
                }
                
                query = "INSERT INTO \(tbl_medication) (\(field_medicationTypeId),\(field_medicationType),\(field_medicationText),\(field_timeStamp)) VALUES (\(id),'\(name)','\(type)',\(timeStamp)) ;"
                
                
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
    
    
    func loadMedications() -> [MedicationDataDisplayModel]! {
        
        var arrMedication: [MedicationDataDisplayModel] = []
        
        let query = "SELECT * FROM \(tbl_medication)"
        
        do {
            
            self.fetchResultSet(query: query, values: [], completionHandler: { (success, results:FMResultSet) in
                if success{
                    while results.next()  {
                        
                        let medicationData = prepareMedicationModelFromResult(results: results)
                        arrMedication.append(medicationData)
                    }
                }
            })
            
            
        }
        
        
        return arrMedication
    }
    
    func prepareMedicationModelFromResult(results:FMResultSet)->MedicationDataDisplayModel{
        
        let medicationTypeId = Int((results.int(forColumn: field_medicationTypeId)))
        let medicationText = results.string(forColumn: field_medicationText)
        let timeStamp = results.double(forColumn: field_timeStamp)
        let medicationData = MedicationDataDisplayModel(id: MedicationId(rawValue: medicationTypeId)!, txtValue: medicationText ?? "", timeStamp: timeStamp )
        
        return medicationData
    }
    
    
    func deleteMedication(model:MedicationDataDisplayModel) -> Bool {
        var deleted = false
        guard let timeStamp = model.timeStamp   else {
            database.close()
            return false;
        }
        
        let query = "DELETE from \(tbl_medication) where \(field_timeStamp)=?"
        
        do {
            updateResultSet(query: query, values: [timeStamp]) {(success,error) in
                if success{
                    deleted = true
                }
            }
            
        }
        
        return deleted
    }
    
    //MARK:- Condition
    func insertConditionData(completionHandler: (_ success:Bool,_ error:Error?) -> Void) {
        if openDatabase() {
            
            do {
                
                var query = ""
                //                for conditionTitle in ConditionType.allCases {
                //                    if conditionTitle != ConditionType(rawValue: ""){
                //                        print("conditionTitle--->",conditionTitle)
                //                        //Here is first select condition, if it's not exist insert into database, so duplicate entry can't be done.
                //                        query += "insert into conditions (\(field_ConditionName)) SELECT ('\(conditionTitle.rawValue)') WHERE not exists (select * from conditions where (\(field_ConditionName)) = ('\(conditionTitle.rawValue)'));"
                //                    }
                //                }
                for condition in arrConditionData.sorted(by: {$0.key<$1.key}){
                    let conditionId = condition.key
                    let conditionaName = condition.value
                    let timeStamp = 0//getTimeStampForCurrenTime()
                    Log.d("conditionId--\(conditionId)")
                    query += "INSERT INTO \(tbl_conditions) (\(field_ConditionID),\(field_ConditionName),\(field_timeStamp)) VALUES (\(conditionId),'\(conditionaName)',\(timeStamp)) ;"
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
    
    
    func loadConditions() -> [ConditionsModel] {
        var conditions: [ConditionsModel] = []
        
        // let query = "select * from conditions order by \(field_ConditionName) asc"
        let query = "select * from conditions"
        do {
            
            self.fetchResultSet(query: query, values: [], completionHandler: { (success, results:FMResultSet) in
                if success{
                    while (results.next()) {
                        let condition = prepareConditionModelFromResult(results: results)
                        
                        conditions.append(condition)
                    }
                }
            })
            
            
        }
        
        return conditions
    }
    
    func loadOnConditionsOnly() -> [ConditionsModel]! {
        var conditions: [ConditionsModel] = []
        
        let query = "select * from conditions where \(field_ConditionIsSelected)=1"
        
        do {
            
            self.fetchResultSet(query: query, values: [], completionHandler: { (success, results:FMResultSet) in
                if success{
                    while results.next() {
                        let condition = prepareConditionModelFromResult(results: results)
                        
                        conditions.append(condition)
                    }
                }
            })
            
            
        }
        
        
        return conditions
    }
    
    func prepareConditionModelFromResult(results:FMResultSet)->ConditionsModel{
        var isSelected = 0
        isSelected =  Int((results.int(forColumn: field_ConditionIsSelected)))
        let conditionId = Int((results.int(forColumn: field_ConditionID)))
        let startTime = Double((results.double(forColumn: field_timeStamp)))
        //============================================================================================//
        //====== Filer global condition array with Id' from Database to fetch Name of Condition========//
        let filterConditionArray = arrConditionData.filter({$0.key == conditionId})
        var conditionName = ""
        if filterConditionArray.count > 0{
            conditionName = filterConditionArray.first?.value.rawValue ?? ""
        }
        //============================================================================================//
        let condition = ConditionsModel(title: conditionName, value:ConditionValue(rawValue: Double(isSelected))!, conditionId: conditionId)
        condition.startTime = startTime
        return condition
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
    func insertSingleCondition(withID ID: Int, timeStamp: Double,completionHandler: (_ success:Bool,_ error:Error?) -> Void) {
        if openDatabase() {
            
            do {
                
                var query = ""
                
                query += "INSERT INTO \(tbl_conditions) (\(field_ConditionID),\(field_ConditionIsSelected),\(field_timeStamp)) VALUES (\(ID),1,\(timeStamp)) ;"
                
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
    
    func deleteCondition(withID ID: Int) -> Bool {
        var deleted = false
        
        
        let query = "delete from conditions where \(field_ConditionID)=?"
        
        do {
            updateResultSet(query: query, values: [ID]) {(success,error) in
                if success{
                    deleted = true
                }
            }
            
            
        }
        
        return deleted
    }
    
}
