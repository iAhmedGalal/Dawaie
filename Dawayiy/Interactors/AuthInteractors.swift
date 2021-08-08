//
//  AuthInteractors.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import SwiftyJSON
import MBProgressHUD

class AuthInteractors: NSObject {
    func login(parameters: [String : Any], completion:  @escaping (_ :LoginModel?,_ :NSError?)->Void) {
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: Constants.Urls.login, withQueryStringParameters:
        parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            if error == nil {
                completion(LoginModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func logout(parameters: [String : Any], completion:  @escaping (_ :PostModel?,_ :NSError?)->Void) {
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: Constants.Urls.logout, withQueryStringParameters:
        parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            if error == nil {
                completion(PostModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func signup(parameters: [String : Any] , completion:  @escaping (_ :SignupModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.signup
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: url, withQueryStringParameters: parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            if error == nil {
                completion(SignupModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func sendResetCode(parameters: [String : Any] , completion:  @escaping (_ :ResetPasswordModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.sendResetCode
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: url, withQueryStringParameters: parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            if error == nil {
                completion(ResetPasswordModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func getNewPassword(parameters: [String : Any] , completion:  @escaping (_ :ResetPasswordModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.resetPassword
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: url, withQueryStringParameters: parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            if error == nil {
                completion(ResetPasswordModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func updatePassword(parameters: [String : Any], completion:  @escaping (_ :PostModel?,_ :NSError?)->Void) {
        let url = Constants.Urls.updatePassword
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: url, withQueryStringParameters: parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            if error == nil {
                completion(PostModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
    func saveUserInfo(parameters: [String : Any], completion:  @escaping (_ :PostModel?,_ :NSError?)->Void) {
        ServiceProvider().sendUrl(showActivity: true, method: .post, URLString: Constants.Urls.editProfileSave, withQueryStringParameters:
        parameters as [String : AnyObject], withHeaders: [:]) { (response, error) in
            if error == nil {
                completion(PostModel(JSON:response as! [String:Any]), error)
            }else {
                completion(nil, error)
            }
        }
    }
    
}
