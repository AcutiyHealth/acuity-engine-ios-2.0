import Foundation
import Alamofire
import CFNetwork
import SystemConfiguration

//public var kBaseUrl:String! = WebServiceConstants.kBaseURL



enum HTTPMETHOD {
    case GET
    case POST
    case PUT
    case DELETE
}


class DDWebService {
    public var isJsonRequest:Bool? = false
    public var useAlmofire:Bool? = false
    public var kGenericError = "We are unable to proceed your request. Please try again later"
    public var kNoInternetConnection = "Internet connection not available. Please try again later"
    public var kUnSupportedMethod = "Unsupported method."
    public var timeoutInterval:TimeInterval = 0
    
    
    func getFinalUrl(method: String) -> String{
        return  WebServiceConstants.kBaseURL + method
    }
    
    func getFinalPaymentUrl(method: String) -> String{
        return WebServiceConstants.kPaymentBaseURL + method
    } //========================================================================================================
    
    // MARK: Webservice calling methods
    // @description : This method will be used to perfom HTTP GET request and will return json response if request will be executed or will return failure message.
    // @params : methodName - method name of http request
    // @params : httpMethods - http method names
    // @params : parameters - Http body parameters
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func callWebservice(method:String,httpMethod:HTTPMETHOD,parameters:[String : Any]?,headers:[String : Any]?,success: @escaping (_ response:AnyObject,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void){
        if isInternetAvailable() == false{
            failure(self.kNoInternetConnection,1000)
        }else if self.useAlmofire == true{
            //UIApplication.shared.isNetworkActivityIndicatorVisible = true
            callAlmofireWebservice(method: method, httpMethod: httpMethod, parameters: parameters, headers: headers, success: { (response, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                success(response, statusCode)
            }, failure: { (error, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                failure(error,statusCode)
            })
        } else{
            //UIApplication.shared.isNetworkActivityIndicatorVisible = true
            var request = self.generateRequest(method: method, httpMethod:httpMethod)
            
            if httpMethod != HTTPMETHOD.GET{
                if headers != nil{
                    request = self.addheadersTo(request: request!, headers: headers)
                }
                if parameters != nil{
                    request = self.addDataToRequest(parameters: parameters!, request: request!)
                }
            }
            self.dataTaskWith(request: request!, success: { (response, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                success(response, statusCode)
            }, failure: { (error, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                failure(error,statusCode)
            })
        }
    }
    
    //========================================================================================================
    
    // @description : This method will be used to perform multi part form data request.
    // @params : methodName - method name of http request
    // @params : httpMethods - http method names
    // @params : parameters - Http body parameters
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func callFilePostWebservice(method:String,httpMethod:HTTPMETHOD,parameters:[String : Any]?,headers:[String : Any]?,fileParameterName:String,fileName:String,mimeType:String,fileData:Data,success: @escaping (_ response:AnyObject,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void,progress:@escaping (_ currentProgress:Double)-> Swift.Void){
        if isInternetAvailable() == false{
            failure(self.kNoInternetConnection,1000)
        }else if self.useAlmofire == true{
            //UIApplication.shared.isNetworkActivityIndicatorVisible = true
            alamofireMultipatFormDataWithProgress(data: fileData, name: fileParameterName, fileName: fileName, mimeType: mimeType, url: getFinalUrl(method: method), parameters: parameters!,headers:headers, success: { (response, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                success(response as AnyObject, statusCode)
            }, failure: { (error, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                failure(error,statusCode)
            }, uploadProgress: { (uploadProgress) in
                progress(uploadProgress)
            })
        } else{
            //UIApplication.shared.isNetworkActivityIndicatorVisible = true
            var request = self.generateRequest(method: method, httpMethod:httpMethod)
            
            if httpMethod != HTTPMETHOD.GET{
                if headers != nil{
                    request = self.addheadersTo(request: request!, headers: headers)
                }
                
                if parameters != nil{
                    request = self.addDataFilePostBody(parameters: parameters, fileParameterName: fileParameterName, fileName: fileName, fileData: fileData, mimeType: mimeType, request: request!)
                }
            }
            self.dataTaskWith(request: request!, success: { (response, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                success(response, statusCode)
            }, failure: { (error, statusCode) in
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                failure(error,statusCode)
            })
            
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
    
    func callAlmofireWebservice(method:String,httpMethod:HTTPMETHOD,parameters:[String : Any]?,headers:[String : Any]?,success: @escaping (_ response:AnyObject,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void){
        if httpMethod == HTTPMETHOD.GET{
            alamofireGETRequest(methodName: method, parameters: parameters, headers: headers, success: { (response, statusCode) in
                success(response as AnyObject, statusCode)
            }, failure: { (error, statusCode) in
                failure(error,statusCode)
            })
        } else if httpMethod == HTTPMETHOD.POST{
            alamofirePOSTRequest(methodName: method, parameters: parameters, headers: headers, success: { (response, statusCode) in
                success(response as AnyObject, statusCode)
            }, failure: { (error, statusCode) in
                failure(error,statusCode)
            })
        } else if httpMethod == HTTPMETHOD.PUT{
            alamofirePUTRequest(methodName: method, parameters: parameters, headers: headers, success: { (response, statusCode) in
                success(response as AnyObject, statusCode)
            }, failure: { (error, statusCode) in
                failure(error,statusCode)
            })
        } else if httpMethod == HTTPMETHOD.DELETE{
            alamofireDELETERequest(methodName: method, parameters: parameters, headers: headers, success: { (response, statusCode) in
                success(response as AnyObject, statusCode)
            }, failure: { (error, statusCode) in
                failure(error,statusCode)
            })
        } else{
            failure(kUnSupportedMethod,1000)
        }
    }
    
    //========================================================================================================
    
    // @description : This method will be used to perfom HTTP GET request and will return json response if request will be executed or will return failure message.
    // @params : methodName - method name of http request
    // @params : parameters - Http body parameters
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func alamofireGETRequest(methodName:String,parameters:[String : Any]?,headers:[String : Any]?,success: @escaping (_ response:Any,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void){
        
        /*if methodName.contains("query.php") {
            
            let url = getFinalPaymentUrl(method: methodName)
            let param = parameters//afRequestParameters(params: parameters)
            let head = afRequestHeaders(headers: headers)
            Log.d(url)
            //Log.d(param!)
            Log.d(head!)
            AF.request(url, method: .get, parameters: nil , encoding: URLEncoding.default, headers: head!).responseString { (response) in
                if let httpResponse:HTTPURLResponse  = response.response{
                    if response.data != nil {
                        success(response.value as? Any,httpResponse.statusCode)
                    } else{
                        failure(self.kGenericError,(httpResponse.statusCode))
                    }
                }  else {
                    failure(self.kGenericError,400)
                }
            }
        } else {*/
            
            AF.request(getFinalUrl(method: methodName),method: .get, parameters: afRequestParameters(params: parameters) , encoding: isJsonRequest == true ? JSONEncoding.default : URLEncoding.default, headers: afRequestHeaders(headers: headers)).responseJSON { response in
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
       // }
    }
    //========================================================================================================
    
    // @description : This method will be used to perfom HTTP POST request and will return json response if request will be executed or will return failure message.
    // @params : methodName - method name of http request
    // @params : parameters - Http body parameters
    // @params : parameters - Http header parameters
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func alamofirePOSTRequest(methodName:String,parameters:[String : Any]?,headers:[String : Any]?,success: @escaping (_ response:Any,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void){
        if methodName == "transact.php" {
            
            let url = getFinalPaymentUrl(method: methodName)
            let param = parameters//afRequestParameters(params: parameters)
            let head = afRequestHeaders(headers: headers)
            Log.d(url)
            Log.d(param!)
            Log.d(head!)
            AF.request(url, method: .post, parameters: param! , encoding: URLEncoding.default, headers: head!).responseString { (response) in
                if let httpResponse:HTTPURLResponse  = response.response{
                    if response.data != nil {
                        success(response.value as? Any,httpResponse.statusCode)
                    } else{
                        failure(self.kGenericError,(httpResponse.statusCode))
                    }
                }  else {
                    failure(self.kGenericError,400)
                }
            }
        } else if methodName.contains("query.php") {
            
            let url = getFinalPaymentUrl(method: methodName)
            let param = parameters//afRequestParameters(params: parameters)
            let head = afRequestHeaders(headers: headers)
            Log.d(url)
            //Log.d(param!)
            Log.d(head!)
            AF.request(url, method: .get, parameters: nil , encoding: URLEncoding.default, headers: head!).responseString { (response) in
                if let httpResponse:HTTPURLResponse  = response.response{
                    if response.data != nil {
                        success(response.value as? Any,httpResponse.statusCode)
                    } else{
                        failure(self.kGenericError,(httpResponse.statusCode))
                    }
                }  else {
                    failure(self.kGenericError,400)
                }
            }
        } else {
            AF.request(getFinalUrl(method: methodName),method: .post, parameters: afRequestParameters(params: parameters), encoding: isJsonRequest == true ? JSONEncoding.default : URLEncoding.default, headers:afRequestHeaders(headers: headers)).responseJSON { response in
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
        
    }
    
    //========================================================================================================
    
    // @description : This method will be used to perfom HTTP PUT request and will return json response if request will be executed or will return failure message.
    // @params : methodName - method name of http request
    // @params : parameters - Http body parameters
    // @params : parameters - Http header parameters
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func alamofirePUTRequest(methodName:String,parameters:[String : Any]?,headers:[String : Any]?,success: @escaping (_ response:Any,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void){
        AF.request(getFinalUrl(method: methodName),method: .put, parameters: afRequestParameters(params: parameters), encoding: isJsonRequest == true ? JSONEncoding.default : URLEncoding.default, headers:afRequestHeaders(headers: headers)).responseJSON { response in
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
    
    // @description : This method will be used to perfom HTTP DELETE request and will return json response if request will be executed or will return failure message.
    // @params : methodName - method name of http request
    // @params : parameters - Http body parameters
    // @params : parameters - Http header parameters
    // @params : success - Success completion block which will return response and status code
    // @params : failure - Failure completion block which will return error message and status code
    
    //========================================================================================================
    
    func alamofireDELETERequest(methodName:String,parameters:[String : Any]?,headers:[String : Any]?,success: @escaping (_ response:Any,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void){
        AF.request(getFinalUrl(method: methodName),method: .delete, parameters: afRequestParameters(params: parameters), encoding: isJsonRequest == true ? JSONEncoding.default : URLEncoding.default, headers:afRequestHeaders(headers: headers)).responseJSON { response in
            if let httpResponse:HTTPURLResponse  = response.response{
                if let JSON = response.value {
                    success(JSON as AnyObject,(httpResponse.statusCode))
                }else {
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
    
    func alamofireMultipatFormDataWithProgress(data:Data,name:String,fileName:String,mimeType:String,url:String,parameters:[String:Any],headers:[String : Any]?,success: @escaping (_ response:Any,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void,uploadProgress:@escaping (_ currentProgress:Double)-> Swift.Void){
        
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
    
    // MARK: Custom methods
    // @description : This method will be used to convert json string to dictionary.
    // @params : text - json string
    // @return : dictionary of type [String : Any]
    
    //========================================================================================================
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                //                Log.d(error.localizedDescription)
            }
        }
        return nil
    }
    
    //========================================================================================================
    
    // @description : This method will be used to convert dictionary to urlencoded string.
    // @params : dictionary - parameters dictionary
    // @return : url encoded string
    
    //========================================================================================================
    
    func urlencoded(dictionary:[String : Any]) -> String{
        var mergedString = ""
        for (key,value) in dictionary {
            if value is String{
                mergedString = mergedString + urlencodedString(string: key) + "=" + (value as! String) + "&"
            } else{
                return ""
            }
        }
        
        let index = mergedString.index(mergedString.startIndex, offsetBy:mergedString.count-1)
        //return mergedString.substring(to: index)
        return String(mergedString[..<index])
        
    }
    
    //========================================================================================================
    
    // @description : This method will be used to convert string to urlencoded string.
    // @params : string - string to be url encoded
    // @return : url encoded string
    
    //========================================================================================================
    
    func urlencodedString(string:String) -> String{
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
        let escapedString = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        return escapedString! as String
    }
    
    //========================================================================================================
    
    // @description : This method will be used to convert object to json data.
    // @params : object - any object
    // @return : json data
    
    //========================================================================================================
    
    func jsonDataFrom(object:[String : Any]) -> Data?{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options:[])
            if String(data: jsonData, encoding: String.Encoding.utf8) != nil {
                let newString = "{\"getTransactionDetailsRequest\":{\"merchantAuthentication\":{\"name\":\"978dfTH9\",\"transactionKey\":\"62NqJd4pT465E3At\"},\"transId\":\"12345\"}}";
                return newString.data(using: .utf8)
            } else{
                return nil
            }
        } catch {
            return nil
        }
    }
    
    //========================================================================================================
    
    // @description : This method will be used to check reachability.
    // @return : true if internet connection available else will return false
    
    //========================================================================================================
    
    func isInternetAvailable() -> Bool{
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
    
    // @description : This method will be used to create URLRequest from method and httpmethod.
    // @return : URLRequest object
    
    //========================================================================================================
    
    func generateRequest(method:String,httpMethod:HTTPMETHOD) -> URLRequest?{
        var request:URLRequest = URLRequest(url: URL(string: getFinalUrl(method: method))!)
        if httpMethod == HTTPMETHOD.GET{
            request.httpMethod = "GET"
        } else if httpMethod == HTTPMETHOD.POST{
            request.httpMethod = "POST"
        } else if httpMethod == HTTPMETHOD.PUT{
            request.httpMethod = "PUT"
        } else if httpMethod == HTTPMETHOD.DELETE{
            request.httpMethod = "DELETE"
        } else {
            request.httpMethod = "GET"
        }
        if self.timeoutInterval != 0{
            request.timeoutInterval = timeoutInterval as TimeInterval
        }
        
        return request
    }
    
    //========================================================================================================
    
    // @description : This method will be used add header fields to request.
    // @params :request - URLRequest object
    // @params : headers - Header fields
    
    //========================================================================================================
    
    func addheadersTo(request:URLRequest,headers:[String : Any]?) -> URLRequest{
        var request:URLRequest = request
        for (key,value) in headers! {
            request.setValue((value as! String), forHTTPHeaderField: key)
        }
        return request
    }
    
    //========================================================================================================
    
    // @description : This method will be used add data to request.
    // @params :request - URLRequest object
    // @params : parameters - body parameters
    
    //========================================================================================================
    
    
    func addDataToRequest(parameters:[String : Any]?,request:URLRequest) -> URLRequest{
        var request:URLRequest = request
        if isJsonRequest == true{
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = self.jsonDataFrom(object: parameters!)
        } else{
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = self.urlencoded(dictionary: parameters!).data(using: .utf8)
        }
        return request
    }
    
    //========================================================================================================
    
    // @description : This method will be used add data to request.
    // @params :request - URLRequest object
    // @params : parameters - body parameters
    
    //========================================================================================================
    
    
    func addDataFilePostBody(parameters:[String : Any]?,fileParameterName:String,fileName:String,fileData:Data,mimeType:String,request:URLRequest) -> URLRequest{
        var request:URLRequest = request
        let boundry:String = "0xKhTmLbOuNdArY"
        request.setValue("multipart/form-data; boundary=\(boundry)", forHTTPHeaderField: "Content-Type")
        let data = NSMutableData()
        data.append("--\(boundry)\r\n".data(using:.utf8)!)
        if self.isJsonRequest == true{
            data.append(self.jsonDataFrom(object: parameters!)!)
        } else{
            for (key,value) in parameters! {
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)\r\n".data(using: .utf8)!)
            }
        }
        data.append("--\(boundry)\r\n".data(using:.utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(fileParameterName)\"; filename=\"\(fileName)\"\r\n".data(using:.utf8)!)
        data.append("Content-Type: \(mimeType)\r\n\r\n".data(using:.utf8)!)
        data.append(fileData)
        data.append("\r\n".data(using:.utf8)!)
        data.append("--\(boundry)--\r\n".data(using:.utf8)!)
        request.httpBody = data as Data
        return request
    }
    
    //========================================================================================================
    
    // @description : This method will create data task request.
    // @params :request - URLRequest object
    
    //========================================================================================================
    
    func dataTaskWith(request:URLRequest,success: @escaping (_ response:AnyObject,_ statusCode:Int?) -> Swift.Void,failure: @escaping (_ error:String,_ statusCode:Int?) -> Swift.Void){
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            //UIApplication.shared.isNetworkActivityIndicatorVisible = false
            let httpResponse = response as! HTTPURLResponse
            if error != nil{
                failure((error?.localizedDescription)!,httpResponse.statusCode)
            }else{
                do{
                    let object = try JSONSerialization.jsonObject(with: data!, options: [])
                    success(object as AnyObject,httpResponse.statusCode)
                    
                }catch{
                    failure(error.localizedDescription,httpResponse.statusCode)
                }
            }
        }
        
        task.resume()
    }
    
    func afRequestParameters(params:[String:Any]?)->Parameters? {
        
        if let requestParam = params,  requestParam.count > 0 {
            
            var dictParam:[String:String] = [String:String]()
            
            for (key, value) in requestParam {
                dictParam[key] = "\(value)"
            }
            return dictParam as Parameters
        }
        return nil
    }
    
    func afRequestHeaders(headers:[String:Any]?) -> HTTPHeaders? {
        
        if let requestHeader = headers,  requestHeader.count > 0 {
            
            var dictHeader:HTTPHeaders = HTTPHeaders()
            
            for (key, value) in requestHeader {
                dictHeader[key] = "\(value)"
            }
            return dictHeader
        }
        return nil
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





