//
//  APIResponseModel.swift
//  Belanger Recycling
//
//  Created by Jignesh Fadadu on 19/08/19.
//  Copyright © 2019 DevDigital LLC. All rights reserved.
//

import Foundation

//========================================================================================================
// PRAGMA MARK:- RESPONSE_TYPE Enum
//========================================================================================================
enum RESPONSE_TYPE : Int {
    case success = 0
    // SUCCESS
    case error
    // DATA PROCESSING OR OTHER ERROR
    case failure
}


//========================================================================================================
// PRAGMA MARK:- APIResponseModel Class
//========================================================================================================
class APIResponseModel {
    var responseType: RESPONSE_TYPE?
    var object: AnyObject?
    var errors: [AnyObject]? = []
    var error: APIError?
    var successMessage:String? = ""
    var failureMessage:String? = ""
    var errorMessage:String? = ""
    var attributes: Attributes?
    var statusCode: Int? = 0
    var requestModel: APIRequestModel?
}

//========================================================================================================
// PRAGMA MARK:- Attributes Class
//========================================================================================================
class Attributes: Codable {
    var count: Int? = 0
    var offset: Int? = 0
    var limit: Int? = 0
}

//========================================================================================================
// PRAGMA MARK:- APIError Class
//========================================================================================================
class APIError : Codable {
    let code:String?
    let message:String?
}

