//
//  WebServiceManager.swift
//  Belanger Recycling
//
//  Created by DevDigital on 19/08/19.
//  Copyright © 2019 DevDigital LLC. All rights reserved.
//

import Foundation
import CFNetwork
import SystemConfiguration
import Alamofire
import SVProgressHUD

class WebServiceManager : NSObject {
    
    //========================================================================================================
    // PRAGMA MARK: - Shared Method
    //========================================================================================================
    class func sharedServiceManager() -> WebServiceManager? {
        var sharedInstance: WebServiceManager? = nil
        var onceToken: Int = 0
        if (onceToken == 0) {
            sharedInstance = WebServiceManager()
            // Do any other initialisation stuff here
        }
        onceToken = 1
        return sharedInstance
    }
    
    //========================================================================================================
    override private init() {
        
    }
    
    //========================================================================================================
    // PRAGMA MARK:- Web Service Method
    //========================================================================================================
    func callWebserviceMethod(requestModel:APIRequestModel, completion: @escaping(APIResponseModel) -> Void){
        
        updateBodyAndHeaderData(requestModel: requestModel)
        
        // Call API
        let webService:DDWebService = DDWebService()
        webService.isJsonRequest = true
        webService.useAlmofire = true
        
        webService.callWebservice(requestModel: requestModel, success: { (response , statusCode) in
            
            let responseModel = APIResponseModel()
            responseModel.statusCode = statusCode!
            
            Log.d(response)
            if(statusCode == APIParameter.kSuccessStatus){
                responseModel.object = response
                responseModel.responseType = .success
                responseModel.successMessage = response[APIParameter.kMessage] as? String
                completion(responseModel)
                
            } else if(statusCode == APIParameter.kUnauthorizeStatus) {
                //TODO: WE here need to handle user unathorised status 401
                responseModel.object = response
                responseModel.responseType = .error
                responseModel.errorMessage = (response as! [String: Any])[APIParameter.kMessage] as? String
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    UserModel.saveUserModel(usermodel: UserModel())
                    UserModel.clearUsermodelFromLocalStorage()
                    UserModel.clearUserDefaultsData(introRequiredAgain: false)
                    let strMessage = responseModel.errorMessage! // "User is logged in on another device."
                    Utility.showAlertWithTitle(title: StringConstants.kApplicationName, message: strMessage, cancelButtonTitle: StringConstants.kOkTitle, withButtons: [], withTag: 0, delegate: self, completion: { (success, index) in
                        SVProgressHUD.showInfo(withStatus: StringConstants.kProcessingMessage)
                        UserManager.shared.authorize { (responseModel) in
                            SVProgressHUD.dismiss()
                            GenericManager.setLoginViewController(appDelegate: UIApplication.shared.delegate! as! AppDelegate)
                        }
                    })
                    completion(responseModel)
                }
            } else {
                responseModel.object = nil
                responseModel.errorMessage = response[APIParameter.kMessage] as? String
                responseModel.responseType = .error
                completion(responseModel)
            }
        }) { (error, statusCode) in
            
            let responseModel = APIResponseModel()
            if statusCode != nil {
                responseModel.statusCode = statusCode!
            } else {
                responseModel.statusCode = 1001
            }
            responseModel.object = nil
            responseModel.failureMessage = error
            responseModel.responseType = .failure
            completion(responseModel)
        }
    }
    
    //========================================================================================================
    // PRAGMA MARK:- File Post Method
    //========================================================================================================
    func callFilePostWebserviceMethod(requestModel: APIRequestModel, completion: @escaping (APIResponseModel) -> Void) {
        
        updateBodyAndHeaderData(requestModel: requestModel)
        
        // Call API
        let webService:DDWebService = DDWebService()
        webService.isJsonRequest = false
        webService.useAlmofire = true
        
        webService.callFilePostWebservice(requestModel: requestModel, success: { (response:AnyObject, statusCode:Int?) in
            
            let responseModel = APIResponseModel()
            responseModel.statusCode = statusCode!
            if (statusCode == APIParameter.kSuccessStatus) {
                
                responseModel.object = response;
                responseModel.responseType  = .success
                responseModel.successMessage = response[APIParameter.kMessage] as? String
                completion(responseModel)
                
            } else if(statusCode == APIParameter.kUnauthorizeStatus){
                
                //                let responseModel = APIResponseModel()
                //                responseModel.statusCode = statusCode
                //                responseModel.object = nil
                //                responseModel.failureMessage = (response as! [String:Any])[APIParameter.kData] as? String
                //                responseModel.responseType = .failure
                //                completion(responseModel)
                //                self.callRefreshTokenWebserviceMethod(APIMethodName.kRefreshTokenMethod, andHttpmethod: .POST, success: { response, statusCode in
                //                    // Retry the service call
                //                    self.callFilePostWebserviceMethod(method, andHttpmethod: httpMethod, params: dict, fileData: data, fileParamName: fileParamName, completion: { (responseModel) in
                //                        completion(responseModel)
                //                    })
                //
                //                }, failure: { error, statusCode in
                //                    let responseModel = APIResponseModel()
                //                    responseModel.statusCode = statusCode
                //                    responseModel.object = nil
                //                    responseModel.failureMessage = error
                //                    responseModel.responseType = .failure
                //                    completion(responseModel)
                //                })
            } else {
                responseModel.object = nil
                responseModel.errorMessage = response[APIParameter.kMessage] as? String
                responseModel.responseType = .error
                completion(responseModel)
            }
            
        }, failure: { (error, statusCode:Int?) in
            print("Failed to image upload")
            
            let responseModel = APIResponseModel()
            if statusCode != nil {
                responseModel.statusCode = statusCode!
            } else {
                responseModel.statusCode = 1001
            }
            responseModel.object = nil
            responseModel.failureMessage = error
            responseModel.responseType = .failure
            completion(responseModel)
        }) { (progress) in
            
        }
    }
    
    //========================================================================================================
    // PRAGMA MARK:- Refresh Token Method
    //========================================================================================================
    func callRefreshTokenWebserviceMethod(success: @escaping (Any?, Int) -> Void, failure: @escaping (String, Int) -> Void) {
        let webService = DDWebService()
        webService.isJsonRequest = false
        webService.useAlmofire = true
        
        var dictHeader: [String:String] = [:]
        if UserDefaults.standard.object(forKey: APIParameter.kAccessToken) != nil {
            if let aToken = UserDefaults.standard.object(forKey: APIParameter.kAccessToken) {
                dictHeader[APIParameter.kAuthorization] = "Bearer \(aToken)"
            }
        }
        
        var params: [String : Any] = [:]
        params[APIParameter.kRefreshToken] =  UserDefaults.standard.object(forKey: APIParameter.kRefreshToken)
        let requestModel = APIRequestModel()
        
        requestModel.httpMethod = .POST
        requestModel.methodName = APIMethodName.kRefreshTokenMethod
        requestModel.bodyParams = params
        requestModel.headerParams = dictHeader
        webService.callWebservice(requestModel: requestModel, success: { (response , statusCode) in
            if (statusCode == APIParameter.kSuccessStatus) {
                // Update access and refresh token values.
                
                UserDefaults.standard.set(response[APIParameter.kAccessToken] as Any, forKey:APIParameter.kAccessToken)
                UserDefaults.standard.set(response[APIParameter.kRefreshToken] as Any, forKey: APIParameter.kRefreshToken)
                UserDefaults.standard.synchronize()
                success(response, statusCode!)
                
            } else if(statusCode == APIParameter.kUnauthorizeStatus){
                
                // Remove access and refresh token values from preference and redirect to Login screen.
                //TODO: throw user to login screen
                
            }
        }) { (error, statusCode) in
            
            // Remove access and refresh token values from preference and redirect to Login screen.
            //TODO: throw user to login screen
        }
    }
    
    //========================================================================================================
    // PRAGMA MARK:- Update Body And Header Parameters Method
    //========================================================================================================
    private func  updateBodyAndHeaderData(requestModel:APIRequestModel){
        var dictHeader: [String:String] = [:]
        dictHeader[APIParameter.kContentType] = APIParameter.kApplicationJson //  APIParameter.kMultiPartFormData
        dictHeader[APIParameter.kAccept] = APIParameter.kApplicationJson
        
        if let aToken = UserModel.getUserModelFromLocalStorage().accessToken {
            // This condition is for logged in user only.
            dictHeader[APIParameter.kAuthorization] = "\(APIParameter.kBearer) \(aToken)"
        } else if let authorizationCode = UserDefaults.standard.value(forKey: APIParameter.kAuthorizationCode) {
            // This condition is for GUEST user only.
            dictHeader[APIParameter.kAuthorizationCode] = "\(authorizationCode)"
        }
        
        requestModel.headerParams = dictHeader
        Log.d("Headers :::: \(requestModel.headerParams!)")
        
        // This check is to avoid unnecessary API response load, in case of blank or nil request perameter.
        var dictParam = requestModel.bodyParams
        if dictParam != nil {   //  || dictParam!.count >= 0 {
            dictParam![APIParameter.kAppVersion] = Utility.applicationVersion()
            dictParam![APIParameter.kDeviceType] = APIParameter.deviceType()
            dictParam![APIParameter.kDeviceID] = Utility.uniqueDeviceId() ?? "12345678"
            
            if dictParam?.count == 0 {
                dictParam = nil
            }
        }
//        else if dictParam != nil && dictParam!.count >= 0 {
//            dictParam![APIParameter.kAppVersion] = Utility.applicationVersion()
//            dictParam![APIParameter.kDeviceType] = APIParameter.deviceType()
//            dictParam![APIParameter.kDeviceID] = "123456"
//        }
        requestModel.bodyParams = dictParam
        Log.d("Body Params :::: \(requestModel.bodyParams ?? [:])")
    }
    
    //========================================================================================================
    // PRAGMA MARK:- Stop API CALL Method
    //========================================================================================================
    func StopAPICALL()  {
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}
