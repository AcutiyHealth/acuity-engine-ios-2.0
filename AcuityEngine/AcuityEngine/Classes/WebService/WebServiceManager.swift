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
//import J

class WebServiceManager : NSObject {
    
    //MARK:- Shared Method
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
    
    override private init() {
        
    }
    
    func showUnathorizedMessage (message:String?) {
        //SVProgressHUD.dismiss()
        //UserManager.shared.setLoginScreenAsRootView(message: message!)
    }
    
    //MARK:- Web Service Method
    func callWebserviceMethod(_ method: String, andHttpmethod httpMethod: HTTPMETHOD, params dict: [String : Any]?, completion: @escaping (APIResponseModel) -> Void) {
        var dictHeader: [String:String] = [:]
        
        dictHeader[APIParameter.kContentType] = APIParameter.kApplicationJson
        dictHeader[APIParameter.kAccept] = APIParameter.kApplicationJson
        
        if UserDefaults.standard.object(forKey: APIParameter.kAccessToken) != nil {
            
            if let aToken = UserDefaults.standard.object(forKey: APIParameter.kAccessToken) {
                dictHeader[APIParameter.kAuthorization] = "Bearer \(aToken)"
            }
            
            
        }
        // This check is to avoid unnecessary API response load, in case of blank or nil request perameter.
        var dictParam = dict
        if dictParam != nil {
            if dictParam?.count == 0 {
                dictParam = nil
            }
        }
        if httpMethod == .GET {
            dictParam = nil
        }
        // Call API
        let webService:DDWebService = DDWebService()
        webService.isJsonRequest = true
        webService.useAlmofire = true
        
        webService.callWebservice(method: method, httpMethod: httpMethod, parameters: dictParam , headers: dictHeader, success: { (response , statusCode) in
            
            let responseModel = APIResponseModel()
            responseModel.statusCode = statusCode!
            
            if(statusCode == APIParameter.kSuccessStatus){
                
                responseModel.object = response
                responseModel.responseType = .success
                responseModel.successMessage = response[APIParameter.kMessage] as? String
                completion(responseModel)
                
            } else if(statusCode == APIParameter.kUnauthorizeStatus) {
                self.showUnathorizedMessage(message: response[APIParameter.kMessage] as? String)
                return
                
                //                let responseModel = APIResponseModel()
                //                responseModel.statusCode = statusCode
                //                responseModel.object = nil
                //                responseModel.failureMessage = response[APIParameter.kMessage] as? String
                //                responseModel.responseType = .failure
                //                completion(responseModel)
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
    
    
    //    //MARK:- File Post Method
    func callFilePostWebserviceMethod(_ method: String?, andHttpmethod httpMethod: HTTPMETHOD, params dict: [String : Any]?, fileData data: Data?, fileParamName: String?, completion: @escaping (APIResponseModel) -> Void) {
        var dictHeader: [String:String] = [:]
        dictHeader[APIParameter.kContentType] = APIParameter.kApplicationJson
        dictHeader[APIParameter.kAccept] = APIParameter.kApplicationJson
        if UserDefaults.standard.object(forKey: APIParameter.kAccessToken) != nil {
            if let aToken = UserDefaults.standard.object(forKey: APIParameter.kAccessToken) {
                dictHeader[APIParameter.kAuthorization] = "Bearer \(aToken)"
            }
        }
        
        // This check is to avoid unnecessary API response load, in case of blank or nil request perameter.
        var dictParam = dict
        if dictParam != nil {
            if dictParam?.count == 0 {
                dictParam = nil
            }
        }
        
        // Call API
        let webService:DDWebService = DDWebService()
        webService.isJsonRequest = false
        webService.useAlmofire = true
        
        webService.callFilePostWebservice(method: method!, httpMethod: httpMethod, parameters: dictParam , headers: dictHeader, fileParameterName: fileParamName!, fileName: "image.jpg", mimeType: "image/jpeg", fileData: data!, success: { (response:AnyObject, statusCode:Int?) in
            
            
            let responseModel = APIResponseModel()
            responseModel.statusCode = statusCode!
            if (statusCode == APIParameter.kSuccessStatus) {
                Log.d("image uploaded")
                responseModel.object = response;
                responseModel.responseType  = .success
                completion(responseModel)
                
            } else if(statusCode == APIParameter.kUnauthorizeStatus){
                self.showUnathorizedMessage(message: response[APIParameter.kMessage] as? String)
                return
                //                let responseModel = APIResponseModel()
                //                responseModel.statusCode = statusCode
                //                responseModel.object = nil
                //                responseModel.failureMessage = (response as! [String:Any])["data"] as? String
                //                responseModel.responseType = .failure
                //                completion(responseModel)
            } else {
                Log.d(responseModel.errors! as Any)
                let errors:[AnyObject] = (response[APIParameter.kErrors] as? [AnyObject])!
                responseModel.errors = errors
                responseModel.errorMessage = errors[0][APIParameter.kMessage] as? String
                responseModel.responseType = .error
                completion(responseModel)
            }
            
        }, failure: { (error, statusCode:Int?) in
            Log.d("Failed to image upload")
            
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
    
    //MARK:- Refresh Token Method
    func callRefreshTokenWebserviceMethod(_ method: String?, andHttpmethod httpMethod: HTTPMETHOD, success: @escaping (Any?, Int) -> Void, failure: @escaping (String, Int) -> Void) {
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
        webService.callWebservice(method: method!, httpMethod: httpMethod, parameters: params, headers: dictHeader, success: { (response , statusCode) in
            if (statusCode == APIParameter.kSuccessStatus) {
                // Update access and refresh token values.
                
                UserDefaults.standard.set(response[APIParameter.kAccessToken] as Any, forKey:     APIParameter.kAccessToken)
                UserDefaults.standard.set(response[APIParameter.kRefreshToken] as Any, forKey: APIParameter.kRefreshToken)
                UserDefaults.standard.synchronize()
                success(response, statusCode!)
                
            } else if(statusCode == APIParameter.kUnauthorizeStatus){
                // Remove access and refresh token values from preference and redirect to Login screen.
                //TODO: throw user to login screen
                //                UserManager.shared.setLoginScreenAsRootView()
                self.showUnathorizedMessage(message: response[APIParameter.kMessage] as? String)
                return
                
            }
        }) { (error, statusCode) in
            // Remove access and refresh token values from preference and redirect to Login screen.
            //TODO: throw user to login screen
            //            UserManager.shared.setLoginScreenAsRootView()
        }
    }
    
}

