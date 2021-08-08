//
//  SignupModel.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct SignupModel: Mappable  {
    var status: Bool?
    var advertiser_id: Int?
    var error : [String]?
    
    var user: LoginData?
    var message: String?


    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        error <- map["error"]
        user <- map["user"]
        message <- map["message"]

    }
    
    
}

