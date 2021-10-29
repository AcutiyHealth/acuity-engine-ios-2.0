//
//  PreventionManager.swift
//  ProjectStructureNew
//
//  Created by Jignesh Fadadu on 20/11/19.
//  Copyright © 2019 Jignesh Fadadu. All rights reserved.
//

import Foundation
//import SVProgressHUD

class PreventionManager {
    
    static let shared = PreventionManager()
    var prevention:PreventionModel!
    //var setting: SettingModel!
    init(){}
    
    func updatePreventionResponse (response:APIResponseModel) {
        
        if let data = try? JSONSerialization.data(withJSONObject: response.object!, options: .prettyPrinted),
           let jsonString = String(data: data, encoding: .utf8) {
            
            let jsonData = jsonString.data(using: .utf8)!
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.prevention = try! decoder.decode(PreventionModel.self, from: jsonData)
            
            //self.Prevention = PreventionModel
            
            //self.Prevention?.accessToken = Utility.fetchString(forKey: APIParameter.kAccessToken)
            //self.Prevention?.refreshToken = Utility.fetchString(forKey: APIParameter.kRefreshToken)
            
            //Utility.setObjectForKey(jsonData, key: APIParameter.kPreventionObject)
        }
    }
    
    //Call get Prevention profile API
    func callPreventionWebserviceMethod(completion: @escaping (APIResponseModel) -> Void) {
        WebServiceManager.sharedServiceManager()?.callWebserviceMethod("json?key=bc420e121aa0dad54de6e2d9a26b4d92", andHttpmethod: .GET, params: nil, completion: { (response) in
            if(response.responseType == .success){
                self.updatePreventionResponse(response: response)
            }
            completion(response)
        })
    }
    /*lazy var genderArray:[String] = {
     var genderArray = Array<String>()
     genderArray.append("Male")
     genderArray.append("Female")
     genderArray.append("Other")
     return genderArray
     }()
     
     lazy var appDisplayDateFormatter:DateFormatter = {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = ApplicationConstants.kAppDisplayDefaultDateFormat
     dateFormatter.timeZone = .current
     return dateFormatter
     }()
     lazy var datePicker: UIDatePicker = {
     let datePicker = UIDatePicker()
     datePicker.maximumDate = Date()
     datePicker.timeZone =  .current
     // datePicker.addTarget(self, action: #selector(didSelectDate(_:)), for: .valueChanged)
     datePicker.datePickerMode = .date
     return datePicker
     } ()
     
     
     init(){}
     
     //MARK: - Internal Class Methods
     static func loadObject() -> PreventionModel? {
     
     let PreventionDefaults = PreventionDefaults.standard
     
     guard let decodedPrevention  = PreventionDefaults.object(forKey: APIParameter.kPreventionObject) as? Data else {
     return nil
     }
     do {
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFromSnakeCase
     let PreventionObj = try decoder.decode(PreventionModel.self, from: decodedPrevention)
     return PreventionObj
     } catch let parseError as NSError {
     print("Parse error\(parseError)")
     }
     return nil
     }
     
     func setLoginScreenAsRootView(message:String){
     PreventionDefaults.standard.set(nil, forKey: APIParameter.kAccessToken)
     PreventionDefaults.standard.set(nil, forKey: APIParameter.kPreventionObject)
     Utility.setBoolForKey(false, key: APIParameter.kIsLoggedIn)
     AppUtility.setUpLoginController()
     /*Utility.showAlert(StringConstants.kAppName, withMesssage: message, cancelButtonTitle: LocalizeKey.kOKButtonTitle.localized(), withButtons: [], withTag: 0, onController: UIApplication.getTopViewController()!) { (cancel, tag) in
      AppDelegate().makeLoginAsRootViewController()
      }*/
     }
     //========================================================================================================
     // PRAGMA MARK: - Login/Sign Up Response
     //========================================================================================================
     func parseLoginPreventionResponse(response:APIResponseModel) {
     if let json = response.object as? [String:Any], let Prevention = json["Prevention"] as? [String:Any] {
     if let data = try? JSONSerialization.data(withJSONObject: Prevention, options: .prettyPrinted),
     let jsonString = String(data: data, encoding: .utf8) {
     
     let jsonData = jsonString.data(using: .utf8)!
     
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFromSnakeCase
     let PreventionModel = try! decoder.decode(PreventionModel.self, from: jsonData)
     
     self.Prevention = PreventionModel
     self.Prevention.accessToken = json["access_token"] as? String
     // Set access token values.
     if self.Prevention.accessToken != nil {
     Utility.setStringForKey(self.Prevention.accessToken ?? "", key: APIParameter.kAccessToken)
     }
     
     Utility.setObjectForKey(jsonData, key: APIParameter.kPreventionObject)
     
     Utility.setBoolForKey(true, key: APIParameter.kIsLoggedIn)
     }
     }
     
     }
     //========================================================================================================
     // PRAGMA MARK: - Update Peofile Response
     //========================================================================================================
     func updateProfileResponse (response:APIResponseModel) {
     if let json = response.object as? [String:Any], let Prevention = json["Prevention"] as? [String:Any] {
     if let data = try? JSONSerialization.data(withJSONObject: Prevention, options: .prettyPrinted),
     let jsonString = String(data: data, encoding: .utf8) {
     
     let jsonData = jsonString.data(using: .utf8)!
     
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFromSnakeCase
     self.Prevention = try! decoder.decode(PreventionModel.self, from: jsonData)
     
     Utility.setObjectForKey(jsonData, key: APIParameter.kPreventionObject)
     }
     }
     }
     
     // PRAGMA MARK: - Setting Response
     //========================================================================================================
     func settingResponse (response:APIResponseModel) {
     if let json = response.object as? [String:Any], let Prevention = json["data"] as? [String:Any] {
     if let data = try? JSONSerialization.data(withJSONObject: Prevention, options: .prettyPrinted),
     let jsonString = String(data: data, encoding: .utf8) {
     
     let jsonData = jsonString.data(using: .utf8)!
     
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFromSnakeCase
     self.setting = try! decoder.decode(SettingModel.self, from: jsonData)
     }
     }
     }
     //========================================================================================================
     // PRAGMA MARK: - Prepare dictionary of API Parameters.
     //========================================================================================================
     func getAPIRequestDictionary(formFields: [FormField]) -> [String:String] {
     var dict = [String:String]()
     formFields.forEach({
     if $0.apiKey.count > 0 {
     dict[$0.apiKey] = $0.strValue
     }
     })
     return dict
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Sign Up
     //========================================================================================================
     func registration(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     if(responseModel.responseType == .success){
     self.parseLoginPreventionResponse(response: responseModel)
     }
     completionHandler(responseModel)
     })
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Login
     //========================================================================================================
     func login(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     if(responseModel.responseType == .success){
     self.parseLoginPreventionResponse(response: responseModel)
     }
     completionHandler(responseModel)
     })
     
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Logout
     //========================================================================================================
     func setting(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     if(responseModel.responseType == .success){
     self.settingResponse(response: responseModel)
     }
     completionHandler(responseModel)
     })
     
     }
     //========================================================================================================
     // PRAGMA MARK: - Logout
     //========================================================================================================
     func logout(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     completionHandler(responseModel)
     })
     
     }
     //========================================================================================================
     // PRAGMA MARK: - Get Html Decoded String Message Method
     //========================================================================================================
     func getHtmlDecodedStringMessage(strMessage:String) -> String {
     var strMessage = strMessage
     strMessage = strMessage.replacingOccurrences(of: "<span>", with: "\n", options: NSString.CompareOptions.literal, range: nil)
     strMessage = strMessage.replacingOccurrences(of: "</span>", with: "", options: NSString.CompareOptions.literal, range: nil)
     return strMessage
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Forgot Password
     //========================================================================================================
     func forgotPassword(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     completionHandler(responseModel)
     })
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Change Password
     //========================================================================================================
     func changePassword(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     completionHandler(responseModel)
     })
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Fetch Prevention Profile
     //========================================================================================================
     func fetchProfile(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     if(responseModel.responseType == .success){
     self.updateProfileResponse(response: responseModel)
     }
     completionHandler(responseModel)
     })
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Update Prevention Profile
     //========================================================================================================
     func updateProfile(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     if(responseModel.responseType == .success){
     self.updateProfileResponse(response: responseModel)
     }
     completionHandler(responseModel)
     })
     }
     
     //========================================================================================================
     // PRAGMA MARK: - Update Prevention Profile Picture
     //========================================================================================================
     func uploadProfilePicture(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callFilePostWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     SVProgressHUD.dismiss()
     switch responseModel.responseType! {
     case .success:
     completionHandler(responseModel)
     break
     case .error:
     Utility.showAlertwithOkButton(message: responseModel.errorMessage!, onController: requestModel.controller!)
     completionHandler(responseModel)
     break
     case .failure:
     Utility.showAlertwithOkButton(message: responseModel.failureMessage!, onController: requestModel.controller!)
     completionHandler(responseModel)
     break
     }
     
     })
     }
     
     // PRAGMA MARK: - Forgot Password
     //========================================================================================================
     func sendPushNotifications(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     completionHandler(responseModel)
     })
     }
     
     
     //========================================================================================================
     // PRAGMA MARK: - Contact Us
     //========================================================================================================
     func contactUs(requestModel: APIRequestModel, completionHandler: @escaping (_ responseModel:APIResponseModel) -> Void) {
     //func contactUs(dict:[String:Any], controller:UIViewController, completionHandler: @escaping (_ success:Bool, _ responseModel:APIResponseModel) -> Void) {
     WebServiceManager.sharedServiceManager()?.callWebserviceMethod(requestModel: requestModel, completion: { (responseModel) in
     //WebServiceManager.sharedServiceManager()?.callWebserviceMethod(APIMethodName.kContactUsMethod, andHttpmethod: .POST, params:dict, completion: { (success, responseModel) in
     SVProgressHUD.dismiss()
     switch responseModel.responseType! {
     case .success:
     Utility.showAlertWithTitle(title: StringConstants.kApplicationName, message: responseModel.successMessage!, cancelButtonTitle: StringConstants.kOkTitle, withButtons: [], withTag: 0, delegate: requestModel.controller!, completion: { (sucess, index) in
     requestModel.controller!.navigationController?.popViewController(animated: true)
     })
     break
     case .error:
     Utility.showAlertwithOkButton(message: responseModel.errorMessage!, onController: requestModel.controller!)
     break
     case .failure:
     Utility.showAlertwithOkButton(message: responseModel.failureMessage!, onController: requestModel.controller!)
     break
     }
     completionHandler(responseModel)
     })
     }*/
}
