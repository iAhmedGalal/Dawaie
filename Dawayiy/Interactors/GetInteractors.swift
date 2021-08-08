//
//  GetInteractors.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

class GetInteractors: NSObject {
    func getForms(completion:  @escaping (_ :FormsModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.forms

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(FormsModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
        
    func getColors(completion:  @escaping (_ :ColorsModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.colors

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(ColorsModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func getDivides(completion:  @escaping (_ :DividesModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.divides

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(DividesModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func getSections(completion:  @escaping (_ :SectionsModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.sections

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(SectionsModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func getDiseases(completion:  @escaping (_ :DiseasesModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.diseases

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(DiseasesModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func getSettings(completion:  @escaping (_ :SettingsModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.siteInfo

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(SettingsModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func appVisits(completion:  @escaping (_ :PostModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.appVisits

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(PostModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    //
    
    func GetNotifications(page: String, completion:  @escaping (_ :NotificationModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.getNotifications + "?page=" + page

        ServiceProvider().sendUrl(showActivity: true, method: .get, URLString: url, withQueryStringParameters: nil, withHeaders: [:]) { (response, error) in
            
            if error == nil {
                completion(NotificationModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    
}
