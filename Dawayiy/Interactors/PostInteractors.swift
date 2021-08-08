//
//  PostInteractors.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

class PostInteractors: NSObject {
    func getMedicines(parameters: [String : Any], completion:  @escaping (_ :MedicinesModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.medicines
        
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: url, withQueryStringParameters: parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(MedicinesModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func getMedicineDetails(parameters: [String : Any], completion:  @escaping (_ :DetailsModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.medicineDetails
        
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: url, withQueryStringParameters: parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(DetailsModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
}
