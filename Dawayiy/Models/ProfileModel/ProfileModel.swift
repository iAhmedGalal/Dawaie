//
//  ProfileModel.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileModel : Mappable {
    var status : Bool?
    var data : ProfileData?
    var message: String?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
        message <- map["message"]
    }
}
