//
//  WebServiceConstants.swift
//  AcuityEngine
//
//  Created by DevDigital on 11/10/21.
//

import Foundation

//========================================================================================================
// @description : This key will be used to encrypt and decrypt required APIs using AES-256 Algorithm.
// @params : kEncryptionKey - See description.
//========================================================================================================
// TODO: - This key will be used to encrypt and decrypt required APIs using AES-256 Algorithm.
let kEncryptionKey = "iYtB9FQiEM3HI9r86OKLI2uRRCJsJSvU" //"3uXaaqnsA5rQ4GmyREwKx4cQtCVAgRMJ"

//========================================================================================================
// @description : This enum will be responsible to set application API mode (i.e. LOCAL, DEBUG or LIVE).
// @params : MODE - Define application mode here to access in application, while API call.
//========================================================================================================
// TODO: - Define application mode here to access in application, while API call.
enum MODE {
    case NONE
    case LOCAL
    case DEBUG
    case LIVE
}

//========================================================================================================
// @description : This constant will be responsible to set application API mode on the basis of environment (i.e. LOCAL, DEBUG or LIVE).
// @params : mode - Define application mode in AppDelegate to access base url as per the required mode.
//========================================================================================================
// TODO: - Define base URL as per the application modes.
class WebServiceConstants {
    
    
    static var kDomain = ""
    static var kPayment = ""
    static var kSimplyCarePracticeCode = "fZKS9t"
    static var mode:MODE = .NONE {
        didSet {
            if mode == .LOCAL {
                WebServiceConstants.kDomain = ""
                WebServiceConstants.kHTTPs = "http://"
                
            } else if mode == .DEBUG {
                WebServiceConstants.kDomain = "data.uspreventiveservicestaskforce.org"
                WebServiceConstants.kHTTPs = "https://"
                
            } else if mode == .LIVE {
                WebServiceConstants.kDomain = "data.uspreventiveservicestaskforce.org"
                WebServiceConstants.kHTTPs = "https://"
            }
        }
    }
    
    // TODO: It can be HyperText Transfer Protocol (http://) OR Secure HyperText Transfer Protocol (https://)
    static var kHTTPs = "https://"
    static var kPaymentHTTPs = "https://"
    // TODO: Base URL
    static let kDomainURL = "\(kHTTPs)\(kDomain)"
    //static let kBaseURL = "\(kDomainURL)/api/\(APIVersion.kAPIVersion)/"
    static let kPaymentUrl = "\(kPaymentHTTPs)\(kPayment)"
    static var kBaseURL:String  {
        return "\(WebServiceConstants.kDomainURL)/api/"
    }
    static var kPaymentBaseURL:String  {
        return "\(WebServiceConstants.kPaymentUrl)/api/"
    }
    static var transactURL : String {
        return "\(WebServiceConstants.kPaymentBaseURL)/api/"
    }
    static let kTermsAndConditionURL = "\(kBaseURL)terms-and-conditions"
    static let kPrivacyPolicyURL = "\(kBaseURL)privacy-policy"
}

//========================================================================================================
// @description : This constant will be responsible to set APIVersion.
// @params : kAPIVersion - Define and set required API version here.
//========================================================================================================
struct APIVersion {
    static let kAPIVersion = "v1"
}

//========================================================================================================
// @description : This constant will be responsible to set each API endpoint methods.
// @params : k(EndPoint)Method - Define and set required API endpoint methods here.
// TODO: - Define all API endpoints
//========================================================================================================
struct APIMethodName {
    
    // TODO: :- Feature specific API endpoints
    ///////////////////////////////////////////////////////////////////////////////////////////
    //                                     |                            |                    //
    //            Constants                |       MethodName           |    Method Mode     //
    //                                     |                            |                    //
    ///////////////////////////////////////////////////////////////////////////////////////////
    static let kSignupMethod                    = "signup"                //   POST
    static let kLoginMethod                     = "login"                   //   POST
    static let kLogoutMethod                    = "logout"                  //   DELETE
    static let kForgotPasswordMethod            = "forgotpassword"          //   POST
    static let kChangePasswordMethod            = "change-password"         //   POST
    static let kProfileMethod                   = "profile"                 //   GET
    static let kUpdateProfileMethod             = "profile"                 //   POST
    static let kGetPatient                      = "secondary_patients"      //   GET
    static let kUploadImage                     = "upload"                  //   POST
    // POST
    // TODO: :- This method is no more required with laravel
    static let kRefreshTokenMethod = "refresh-token"
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    //                                     |                            |                    //
    //            Constants                |       MethodName           |    Method Mode     //
    //                                     |                            |                    //
    ///////////////////////////////////////////////////////////////////////////////////////////
}

//========================================================================================================
// @description : This constant will be responsible to set each API perameters.
// @params : k(XYZ) - Define and set required API perameters here.
//========================================================================================================
// TODO: - Define all API parameters
class APIParameter {
    //TODO:  :- API STATUS CODE
    
    static let kSuccessStatus = 202
    static let kUnauthorizeStatus = 401
    
    // TODO: :- GENERIC API parameters
    static let kSuccess = "success"
    static let kMessage = "message"
    
    static let kAccessToken = "access_token"
    static let kAuthorization = "Authorization"
    static let kAttributes = "attributes"
    static let kErrors = "errors"
    static let kError = "error"
    static let kRefreshToken = "refresh_token"
    
    // TODO: :- APP secific API parameters
    static let kUser = "user"
    static let kAccept = "Accept"
    static let kContentType = "Content-Type"
    static let kApplicationJson = "application/json"
    static let kXLocalization = "X-localization"
    static let kUserObject = "user_Object"
    static let kContentLength = "Content-Length"
    static let kHost  = "Host"
    static let kUserAgent = "User-Agent"
    static let kPaymentContentType  = "application/x-www-form-urlencoded"
    static let kPaymentAccept = "*/*"
    static let kAcceptEncoding = "Accept-Encoding"
    static let kConnection = "Connection"
    static let kPaymentUserAgent = "User-Agent"
    
    //  TODO: :- update-device-information
    static let kDeviceID = "device_id"
    static let kDeviceBrand = "device_brand"
    static let kDeviceName = "device_name"
    static let kDeviceVersion = "device_version"
    static let kDeviceToken = "device_token"
    static let kDeviceType = "device_type"
    static let kAppVersion = "app_version"
    static let kAPIVersion = "api_version"
    static let kCurrentTimeZone = "timezone"
    
    // TODO: :- Media (i.e. image) related parameters
    static let kSection = "section"
    static let kSectionUserProfile = "user_profile"
    static let kSectionPost = "post"
    static let kImage = "image"
    static let kMediaType = "media_type"
    static let kMediaName = "media_name"
    static let kMediaNameFilePNG = "file.png"
    static let kMediaNameFileJPEG = "file.jpeg"
    static let kMimeType = "image/jpeg"
    
    //  TODO: :- General parameters
    static let kIsLoggedIn = "isLoggedIn"
    
    static let kEmail = "email"
    static let kPassword = "password"
    static let kName = "name"
    
    // Sign Up
    static let kFirstName = "first_name"
    static let kLastName = "last_name"
    static let kPasswordConfirmation = "password_confirmation"
    static let kPhone = "phone"
    static let kBirthDate = "birth_date"
    
    static let kCurrentPassword = "current-password"
    static let kOldPassword = "old_password"
    static let kNewPassword = "new-password"
    static let kConfirmPassword = "password-confirm"
    
    static let kUserModel = "userModel"
    
    //========================================================================================================
    // TODO: :- Class method to fetch App Version
    //========================================================================================================
    class func appVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    //========================================================================================================
    // TODO: :- Class method to fetch Device Type
    //========================================================================================================
    class func deviceType() -> String {
        return "ios"
    }
}
