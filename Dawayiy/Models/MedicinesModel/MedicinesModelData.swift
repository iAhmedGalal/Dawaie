//
//  MedicinesModelData.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct MedicinesModelData : Mappable {
    var first_page_url : String?
    var last_page_url : String?
    var path : String?
    var data : [MedicinesData]?
    var to : Int?
    var per_page : Int?
    var from : Int?
    var last_page : Int?
    var current_page : Int?
    var next_page_url : String?
    var prev_page_url : String?
    var total : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        first_page_url <- map["first_page_url"]
        last_page_url <- map["last_page_url"]
        path <- map["path"]
        data <- map["data"]
        to <- map["to"]
        per_page <- map["per_page"]
        from <- map["from"]
        last_page <- map["last_page"]
        current_page <- map["current_page"]
        next_page_url <- map["next_page_url"]
        prev_page_url <- map["prev_page_url"]
        total <- map["total"]
    }

}
