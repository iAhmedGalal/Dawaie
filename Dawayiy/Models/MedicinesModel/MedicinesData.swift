//
//  MedicinesData.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct MedicinesData : Mappable {
    var arabic_name : String?
    var english_name : String?
    var Drug_arabic_name : String?
    var Drug_english_name : String?
    var section_name : String?

    var image : String?
    var Drug_image : String?

    
    var id : Int?
    var drug_id : String?
    var color_id : Int?
    var section_id : Int?
    var pill_divide_id : Int?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        arabic_name <- map["arabic_name"]
        english_name <- map["english_name"]
        Drug_arabic_name <- map["Drug_arabic_name"]
        Drug_english_name <- map["Drug_english_name"]
        section_name <- map["section_name"]
        image <- map["image_url"]
        Drug_image <- map["Drug_image"]
        id <- map["id"]
        drug_id <- map["drug_id"]
        color_id <- map["color_id"]
        section_id <- map["section_id"]
        pill_divide_id <- map["pill_divide_id"]
    }

}
