//
//  DetailsModel.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailsModel : Mappable {
    var data : DetailsData?
    var status : Bool?
    var message: String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
        status <- map["status"]
    }

}
