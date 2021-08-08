//
//  DetailsData.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailsData : Mappable {
    var Drug_diseases: [Drug_diseases]?
    var arabic_name : String?
    var english_name : String?
    var section_name : String?
    var side_effects : String?
    var warnings : String?
    var active_substances : String?
    var instructions : String?
    var about : String?
    var image : String?

    var views: Int?
    var in_list: Int?
    var id : Int?
    var color_id : Int?
    var section_id : Int?
    var pill_divide_id : Int?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        Drug_diseases <- map["Drug_diseases"]
        arabic_name <- map["arabic_name"]
        english_name <- map["english_name"]
        section_name <- map["section_name"]
        side_effects <- map["side_effects"]
        warnings <- map["warnings"]
        active_substances <- map["active_substances"]
        instructions <- map["instructions"]
        about <- map["about"]
        image <- map["image_url"]
        views <- map["views"]
        in_list <- map["in_list"]
        id <- map["id"]
        color_id <- map["color_id"]
        section_id <- map["section_id"]
        pill_divide_id <- map["pill_divide_id"]
        
    }

}
