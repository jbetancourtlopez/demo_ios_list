//
//  Pokemon.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import Foundation
import ObjectMapper

class Pokemon: Mappable {
    
    var name: String = ""
    var url: String  = ""
    
    required init?(){}
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        name       <- map["name"]
        url        <- map["url"]
    }
}
