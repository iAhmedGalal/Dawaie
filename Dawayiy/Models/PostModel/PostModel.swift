//
//  PostModel.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostModel : Mappable {
    var message : String?
    var status : Bool?
    var error : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
        error <- map["error"]
    }

}
