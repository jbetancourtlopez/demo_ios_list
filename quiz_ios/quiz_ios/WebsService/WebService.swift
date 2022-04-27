//
//  WebService.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//


import Foundation
import Alamofire
import ObjectMapper

class WebService {
    
    var jsonArray: NSArray?
    
    func requestGet(url: String, parameters: [String : Any],headers: HTTPHeaders? =  ["Content-Type": "application/json",  "Accept": "application/json"], completionHandler: @escaping (_ status: Int, _ data: Any?, _ msg: String) -> ()){
        
        var param_url = url
        
        let string_parameters = dictToUrlParams(parameters: parameters as Dictionary<String, AnyObject>)
        
        if !parameters.isEmpty {
            param_url = "\(url)\(string_parameters)"
        }
        
        print("Log: \(param_url)")
        
       
        print("headers",headers)
        
        Alamofire.request(param_url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
           
            if response.error != nil{
                completionHandler(404, [:], "Error with response status")
            }else{
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        if let value = response.value {
                           completionHandler(200, value, "success")
                        }
                    case 422:
                        if let value = response.value {
                           completionHandler(422, value, "success")
                        }
                    case 406:
                        if let value = response.value {
                           completionHandler(406, value, "success")
                        }
                    default:
                        completionHandler(500, [:], "Error with response status: \(status)")
                    }
                }
            }
        }
    }
    
    func requestPost(url: String, parameters: [String : Any], isJson: Bool, completionHandler: @escaping (_ status: Int, _ data: Any?, _ msg: String) -> () ){

        
           var headers: HTTPHeaders = [
               "Content-Type": "application/json",
               "Accept": "application/json"
           ]
  
           print("headers",headers)
        
           var param_url = ""
           var param_parameter:[String : Any]
           
           if(isJson){
               param_parameter = parameters
               param_url = url
               
           }else{
               param_parameter = [:]
               let string_parameters = dictToUrlParams(parameters: parameters as Dictionary<String, AnyObject>)
               param_url = "\(url)\(string_parameters)"
           }
        print("Log: \(param_url)")
        print("Log: \(param_parameter)")
           Alamofire.request(param_url, method: .post, parameters: param_parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
              
               if let status = response.response?.statusCode {
                   switch(status){
                   case 200:
                       if let value = response.value {
                          completionHandler(200, value, "success")
                       }
                   case 422:
                       if let value = response.value {
                          completionHandler(422, value, "success")
                       }
                   default:
                       completionHandler(500, [:], "Error with response status: \(status)")
                   }
               }
           }
       }
    
    func requestPut(url: String, parameters: [String : Any], isJson: Bool, completionHandler: @escaping (_ status: Int, _ data: Any?, _ msg: String) -> () ){
        
           var headers: HTTPHeaders = [
               "Content-Type": "application/json",
               "Accept": "application/json"
           ]
        
                        print("headers",headers)
           var param_url = ""
           var param_parameter:[String : Any]
           
           if(isJson){
               param_parameter = parameters
               param_url = url
               
           }else{
               param_parameter = [:]
               let string_parameters = dictToUrlParams(parameters: parameters as Dictionary<String, AnyObject>)
               param_url = "\(url)\(string_parameters)"
           }
        
           Alamofire.request(param_url, method: .put, parameters: param_parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
              
               if let status = response.response?.statusCode {
                   switch(status){
                   case 200:
                       if let value = response.value {
                          completionHandler(200, value, "success")
                       }
                   case 422:
                       if let value = response.value {
                          completionHandler(422, value, "success")
                       }
                   default:
                       completionHandler(500, [:], "Error with response status: \(status)")
                   }
               }
           }
       }
    
    func requestDelete(url: String, parameters: [String : Any], isJson: Bool, completionHandler: @escaping (_ status: Int, _ data: Any?, _ msg: String) -> () ){
           
           var headers: HTTPHeaders = [
               "Content-Type": "application/json",
               "Accept": "application/json"
           ]
           
            print("headers",headers)
           var param_url = ""
           var param_parameter:[String : Any]
           
           if(isJson){
               param_parameter = parameters
               param_url = url
               
           }else{
               param_parameter = [:]
               let string_parameters = dictToUrlParams(parameters: parameters as Dictionary<String, AnyObject>)
               param_url = "\(url)\(string_parameters)"
           }
        print("Log: \(param_url)")
           Alamofire.request(param_url, method: .delete, parameters: param_parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
              
               if let status = response.response?.statusCode {
                   switch(status){
                   case 200:
                       if let value = response.value {
                          completionHandler(200, value, "success")
                       }
                   case 422:
                       if let value = response.value {
                          completionHandler(422, value, "success")
                       }
                   default:
                       completionHandler(500, [:], "Error with response status: \(status)")
                   }
               }
           }
       }
    
    func requestPostMultipart(url: String, parameters: [String : Any], fileURL:URL?, fileName:String, isJson: Bool, completionHandler: @escaping (_ status: Int, _ data: Any?, _ msg: String) -> () ){
        
           var headers: HTTPHeaders = [
                "Content-type": "multipart/form-data"
           ]
        
         
            print("headers",headers)
            print("parameters",parameters)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
                   for (key, value) in parameters {
                       multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                   }
            if fileURL != nil {
                multipartFormData.append(fileURL!, withName: fileName)
            }
            
            
               }, to:url,headers: headers)
               { (result) in
                   switch result{
                   case .success(let upload, _, _):
                       upload.responseJSON { response in
                        if let status = response.response?.statusCode {
                            switch(status){
                            case 200:
                                if let value = response.value {
                                   completionHandler(200, value, "success")
                                }
                            case 422:
                                if let value = response.value {
                                   completionHandler(422, value, "success")
                                }
                            default:
                                completionHandler(500, [:], "Error with response status: \(status)")
                            }
                        }

                       }
                   case .failure(_):
                      //print("Error in upload: \(error.localizedDescription)")
                       ()

                   }

               }
        print("Log: \(url)")
       }
    func requestDownloadArchive(url:String, completionHandler: @escaping (_ status: Int, _ documentsURL: URL?, _ msg: String) -> () ){
        
        let headers: HTTPHeaders = [:]
        
       
            print("headers",headers)
          Alamofire.request(url, headers: headers).downloadProgress(closure : { (progress) in
              print(progress.fractionCompleted)

          }).responseData{ (response) in
              print(response)
              print(response.result.value!)
              print(response.result.description)
           
              if let data = response.result.value {
                let status = response.response?.statusCode
                let fileURL = NSURL(fileURLWithPath: url as String)
                let fullname: String = fileURL.lastPathComponent!
                
                var documentsURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last
                documentsURL!.appendPathComponent(fullname)
                  do {
                    try data.write(to: documentsURL!)
                    completionHandler(200, documentsURL, "success")

                  } catch {
                    completionHandler(500, nil,"Error with response status: \(String(describing: status))")
                  }

              }
          }
    }
    // --
      
      func dictToUrlParams( parameters: Dictionary<String,AnyObject> ) -> String{
          var urlParams: String = "?"
          for (myKey,myValue) in parameters {
              urlParams += "\(myKey)=\(myValue)&"
          }
          return urlParams
      }
}
