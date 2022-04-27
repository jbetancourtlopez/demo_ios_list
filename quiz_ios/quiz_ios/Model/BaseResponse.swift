//
//  BaseResponse.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import Foundation
import ObjectMapper


class BaseResponse: Mappable {
    
    var count: Int64 = 0
    var next: String = ""
    var previous: String  = ""
    var results: Any!
    
    required init?(){}
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        count       <- map["count"]
        next        <- map["next"]
        previous    <- map["previous"]
        results     <- map["results"]
    }
}


