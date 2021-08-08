//
//  LoginModel.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct LoginModel : Mappable {
    var status : Bool?
    var active : Bool?
    var data : LoginData?
    var message: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        active <- map["active"]
        data <- map["data"]
        message <- map["message"]
    }
}
