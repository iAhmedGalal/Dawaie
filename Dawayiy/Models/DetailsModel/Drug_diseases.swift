//
//  Drug_diseases.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/23/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper

struct Drug_diseases : Mappable {
    var id : Int?
    var drug_id : Int?
    var disease_id : Int?
    var disease_name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        drug_id <- map["drug_id"]
        disease_id <- map["disease_id"]
        disease_name <- map["disease_name"]
    }

}
