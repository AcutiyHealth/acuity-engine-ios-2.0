//
//  APIRequestModel.swift
//  Belanger Recycling
//
//  Created by Jignesh Fadadu on 16/10/20.
//  Copyright © 2020 DevDigital LLC. All rights reserved.
//

import UIKit

//========================================================================================================
// PRAGMA MARK:- HTTPMETHOD Enum
//========================================================================================================
enum HTTPMETHOD {
    case GET
    case POST
    case PUT
    case DELETE
}

//========================================================================================================
// PRAGMA MARK:- APIResponseModel Struct
//========================================================================================================
struct MultiPartData {
    var name:String? // API Parameter name  (i.e "file" Request parameter name)
    var fileName:String? //  Name server will require to save (i.e. "profile_image" media name profile_image.jpg)
    var mimeType:String? // MIME type of object (i.e image/jpeg, video/mpeg)
    // MIME: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
    var data:Data? // Data of image / video / document
}

//========================================================================================================
// PRAGMA MARK:- APIRequestModel Class
//========================================================================================================
class APIRequestModel {
    
    // HTTP method type
    var httpMethod:HTTPMETHOD = .GET
    
    // Method Name, it must be provided
    var methodName:String = ""
    
    // If any custom header is required to send then
    var headerParams:[String:Any]?
    
    // This is body parameters
    var bodyParams:[String:Any]?
    
    // This is what if we need to send image or video or any MIME type to server
    var multiPartData:[MultiPartData]?

    // This is what if we need to send image or video or any MIME type to server
    var controller:UIViewController?
    
    //========================================================================================================
    // PRAGMA MARK: - This method will return object of requestModel
    //========================================================================================================
    class func generateRequestModel(httpMethod: HTTPMETHOD = .GET, methodName: String, bodyParams: [String:Any] = [String:Any](), headerParams: [String:Any] = [String:Any](), multiPartData:[MultiPartData] = [MultiPartData](), controller: UIViewController?) -> APIRequestModel {
        let requestModel = APIRequestModel()
        requestModel.httpMethod = httpMethod
        requestModel.methodName = methodName
        requestModel.bodyParams = bodyParams
        requestModel.headerParams = headerParams
        requestModel.multiPartData = multiPartData
        requestModel.controller = controller
        return requestModel
    }
}
