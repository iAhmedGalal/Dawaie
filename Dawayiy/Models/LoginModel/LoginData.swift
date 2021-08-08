//
//  LoginData.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct LoginData : Mappable {
    var id : Int?
    var mobile : String?
    var name : String?
    var email : String?
    var api_token : String?
    var status : Bool?
    var message : String?
    var active_code : String?
    var player_id : String?
    var is_doctor: Int?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        mobile <- map["mobile"]
        name <- map["name"]
        email <- map["email"]
        api_token <- map["api_token"]
        message <- map["message"]
        status <- map["status"]
        active_code <- map["active_code"]
        player_id <- map["player_id"]
        is_doctor <- map["is_doctor"]
    }
}
