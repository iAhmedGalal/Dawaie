//
//  ProfileData.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileData : Mappable {
    var id : Int?
    var name : String?
    var mobile : String?
    var e_mail : String?
    var facebook : String?
    var twitter : String?
    var instagram : String?
    var snap : String?
    var followers_count : Int?
    var img : String?
    var block_id: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        mobile <- map["mobile"]
        e_mail <- map["e_mail"]
        facebook <- map["facebook"]
        twitter <- map["twitter"]
        instagram <- map["instagram"]
        snap <- map["snap"]
        followers_count <- map["followers_count"]
        img <- map["img"]
        block_id <- map["block_id"]
    }
}
