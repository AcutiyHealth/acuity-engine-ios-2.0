//
//  DDWebService.swift
//  Belanger Recycling
//
//  Created by Devdigital on 09/01/17.
//  Copyright © 2017 DevDigital LLC. All rights reserved.
//
/*
import Foundation
import Alamofire
import CFNetwork
import SystemConfiguration

class DDWebService {
    
    public var isJsonRequest:Bool? = false
    public var useAlmofire:Bool? = true
    public var kGenericError = "We are unable to proceed your request. Please try again later"
    public var kNoInternetConnection = "Internet connection not available. Please try again later"
    
    //========================================================================================================
    // PRAGMA MARK:- Get Base Url Method
    //========================================================================================================
    func getFinalUrl(method: String) -> String{
        return  WebServiceConstants.kBaseURL + method
    }
    
    //========================================================================================================
    
    // MARK: Webservice calling methods
    // @description : This method will be used to perfom HTTP GET request and will return json response if request will be executed or will return failure message.
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func callWebservice(requestModel:APIRequestModel, success: @escaping (_ response:AnyObject,_ statusCode:Int?) -> Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Void) {
        if isInternetAvailable() == false {
            failure(self.kNoInternetConnection,APIParameter.kNoInternetCode)
        } else if self.useAlmofire == true {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            callAlmofireWebservice(requestModel: requestModel, success: { (response, statusCode) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                success(response, statusCode)
            }, failure: { (error, statusCode) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                failure(error,statusCode)
            })
        }
    }
    
    //========================================================================================================
    
    // @description : This method will be used to perform multi part form data request.
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func callFilePostWebservice(requestModel:APIRequestModel,success: @escaping (_ response:AnyObject,_ statusCode:Int?) -> Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Void,progress:@escaping (_ currentProgress:Double)-> Void) {
        if isInternetAvailable() == false {
            failure(self.kNoInternetConnection,APIParameter.kNoInternetCode)
        } else if self.useAlmofire == true {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            alamofireMulipartData(imageData: requestModel.multiPartData!, parameters: requestModel.bodyParams, url: getFinalUrl(method: requestModel.methodName), headers: requestModel.headerParams, success: { (response, statusCode) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                success(response as AnyObject, statusCode)
            }, failure: { (error, statusCode) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                failure(error,statusCode)
            }) { (uploadProgress) in
                progress(uploadProgress)
            }
        }
    }
    
    //========================================================================================================
    
    // MARK: Alamofire methods
    // @description : This method will be used to perfom HTTP GET request and will return json response if request will be executed or will return failure message.
    // @params : methodName - method name of http request
    // @params : parameters - Http body parameters
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    private func callAlmofireWebservice(requestModel:APIRequestModel,success: @escaping (_ response:AnyObject,_ statusCode:Int?) -> Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Void){
        
        AF.request(getFinalUrl(method: requestModel.methodName),method: afHttpMethodType(httpMethodType: requestModel.httpMethod), parameters: afRequestParameters(params: requestModel.bodyParams) , encoding: isJsonRequest == true ? JSONEncoding.default : URLEncoding.default, headers: afRequestHeaders(headers: requestModel.headerParams)).responseJSON { response in
            if let httpResponse:HTTPURLResponse  = response.response{
                if let JSON = response.value {
                    success(JSON as AnyObject,(httpResponse.statusCode))
                } else{
                    failure(self.kGenericError,(httpResponse.statusCode))
                }
            } else{
                failure(self.kGenericError,400)
            }
        }
    }
    
    //========================================================================================================
    
    // @description : This method will be used to perform multipart formdata request.
    // @params : url - URL of the file to be uploaded.
    // @params : data - Data to be uploaded
    
    //========================================================================================================
    
    private func alamofireMulipartData(imageData:[MultiPartData],parameters:[String:Any]?,url:String, headers:[String : Any]?,success: @escaping (_ response:Any,_ statusCode:Int?) -> Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Void,uploadProgress:@escaping (_ currentProgress:Double)-> Void) {
        AF.upload(multipartFormData: { multiPart in
            if let params = parameters {
                for (key, value) in params {
                    if let temp = value as? String {
                        multiPart.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? Int {
                        multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                                if let num = element as? Int {
                                    let value = "\(num)"
                                    multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
            }

            for imageData in imageData {
                multiPart.append(imageData.data!, withName: imageData.name!, fileName: imageData.fileName, mimeType: imageData.mimeType)
            }
            
            // multiPart.append(data, withName: name, fileName: fileName, mimeType: mimeType)
        }, to: url, method: .post, headers: afRequestHeaders(headers: headers))
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            }) .responseJSON(completionHandler: { data in
                //Do what ever you want to do with response
                if let httpResponse:HTTPURLResponse  = data.response{
                    if let JSON = data.value {
                        print("Reponse : \(JSON)")
                        success(JSON as AnyObject,(httpResponse.statusCode))
                    }else {
                        failure(self.kGenericError,(httpResponse.statusCode))
                    }
                } else{
                    failure(self.kGenericError,400)
                }
            })
    }
    
    private func alamofireMultipatFormDataWithProgress(data:Data,name:String,fileName:String,mimeType:String,url:String,parameters:[String:Any],headers:[String : Any]?,success: @escaping (_ response:Any,_ statusCode:Int?) -> Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Void,uploadProgress:@escaping (_ currentProgress:Double)-> Void){
        
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameters {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(data, withName: name, fileName: fileName, mimeType: mimeType)
        }, to: url, method: .post, headers: afRequestHeaders(headers: headers))
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            }) .responseJSON(completionHandler: { data in
                //Do what ever you want to do with response
                if let httpResponse:HTTPURLResponse  = data.response{
                    if let JSON = data.value {
                        print("Reponse : \(JSON)")
                        success(JSON as AnyObject,(httpResponse.statusCode))
                    }else {
                        failure(self.kGenericError,(httpResponse.statusCode))
                    }
                } else{
                    failure(self.kGenericError,400)
                }
            })
    }
    
    //========================================================================================================
    
    // @description : This method will be used to check reachability.
    // @return : true if internet connection available else will return false
    
    //========================================================================================================
    
    private func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    //========================================================================================================
    // PRAGMA MARK:- AF Request Parameters Method
    //========================================================================================================
    
    private func afRequestParameters(params:[String:Any]?)->Parameters? {
        
        if let requestParam = params,  requestParam.count > 0 {
            
            var dictParam:[String:String] = [String:String]()
            
            for (key, value) in requestParam {
                dictParam[key] = "\(value)"
            }
            return dictParam as Parameters
        }
        return nil
    }
    
    //========================================================================================================
    // PRAGMA MARK:- AF Request Headers Method
    //========================================================================================================
    
    private func afRequestHeaders(headers:[String:Any]?) -> HTTPHeaders? {
        
        if let requestHeader = headers,  requestHeader.count > 0 {
            
            var dictHeader:HTTPHeaders = HTTPHeaders()
            
            for (key, value) in requestHeader {
                dictHeader[key] = "\(value)"
            }
            return dictHeader
        }
        return nil
    }
    
    //========================================================================================================
    // PRAGMA MARK:- AF HTTP Method Type
    //========================================================================================================
    
    private func afHttpMethodType (httpMethodType:HTTPMETHOD) -> HTTPMethod {
        switch httpMethodType {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        }
    }
}

extension Dictionary {
    
    var prettyPrintedJSON: String? {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)
        } catch _ {
            return nil
        }
    }
}
*/
