//
//  GeneralWebservice.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import ObjectMapper


class GeneralService: WebService {
    
  
    func pokemon(parameters: [String : Any], doneFunction:@escaping (_ status: Int, _ data: Array<Pokemon>?, _ msg: String) -> ()){
         
        let url = "\(Config.WebServices.API)pokemon/"
     
         requestGet(url: url, parameters: parameters){ status, data, msg  in
             if(status == 200){
                 
                 var response: BaseResponse
                 response = Mapper<BaseResponse>().map(JSONObject: data)!
                 
                 if(response.count > 0){
                     
                     let anyArray: [[String : Any]] = response.results as! [[String : Any]]
                     let array: Array<Pokemon> = Mapper<Pokemon>().mapArray(JSONArray: anyArray)
                    
                     doneFunction(200, array, "Exito")
                 }
             }
             
             else{
                 doneFunction(500, nil, "Error")
             }
         }
     }
    
    

}

