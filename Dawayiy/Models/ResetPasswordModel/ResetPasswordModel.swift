//
//  ResetPasswordModel.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct ResetPasswordModel: Mappable {
    var status: Bool?
    var user_id: Int?
    var message: String?
    var data: LoginData?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
        user_id <- map["user_id"]
        message <- map["message"]
    }
}
