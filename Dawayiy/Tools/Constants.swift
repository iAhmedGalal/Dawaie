//
//  OFCStrings.swift
//  OrangeFootballClub
//
//  Created by Alaa Taher on 11/15/16.
//  Copyright © 2016 Alaa Taher. All rights reserved.
//

import UIKit

let BaseURL = "http://is2host.com/dwaa/api/v1/"
let SiteURL = "http://is2host.com/dwaa/"

//let BaseURL = "http://192.168.1.28/dwaa/api/v1/"
//let SiteURL = "http://192.168.1.28/dwaa/"

let homeCellHeight:CGFloat = 230.0
let homeCellWidth:CGFloat = 300.0
let myOrderCellHeight = 140.0

let kInternetConnectionNotReachable: String = "NOT_REACHABLE"
let kInternetConnectionReachable: String = "REACHABLE"

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
}

class Constants: NSObject {
    struct Urls {
        static let baseImageURL = SiteURL
        
        static let login = BaseURL + "login"
        static let logout = BaseURL + "logout"
        static let signup = BaseURL + "sign-up"
        static let sendResetCode = BaseURL + "reset-password"
        static let resetPassword = BaseURL + "new-password-save"
        static let updatePassword = BaseURL + "set-new-password"
        static let editProfileSave = BaseURL + "edit-profile"
        
        static let forms = BaseURL + "medication-forms"
        static let colors = BaseURL + "colors"
        static let divides = BaseURL + "pill-divides"

        static let sections = BaseURL + "sections"
        static let diseases = BaseURL + "diseases"
        static let medicines = BaseURL + "get-drugs"
        
        static let myList = BaseURL + "my-drug-list"
        static let addToList = BaseURL + "add-to-list"
        static let removeFromList = BaseURL + "remove-from-list"
        
        static let medicineDetails = BaseURL + "drug-details"
        
        static let getNotifications = BaseURL + "get-notifications"

        static let appVisits = BaseURL + "app-visit"
        static let siteInfo = BaseURL + "site-setting"
    }
    
    struct StatusCode {
        static let StatusOK = 200
        static let StatusCreated = 201
        static let StatusNoContent = 204
        static let StatusNotfound = 404
    }
    
    struct AlertType {
        static let AlertError = 1
        static let AlertSuccess = 2
        static let Alertinfo = 3
        static let AlertWarn = 4
    }
    
    struct userDefault {
        static let userData = "userData"
        static let userToken = "userToken"
        static let userID = "userID"
        static let userName = "userName"
        static let userImage = "userImage"
        static let userMobile = "userMobile"
        static let userEmail = "userEmail"
        static let userPoints = "userPoints"
        static let language = "language"
        static let activeStatus = "activeState"
        static let player_id = "player_id"
    }
    
    struct storyBoard {
        static let authentication = "Authentication"
        static let main = "Main"
        static let adv = "Advertisement"
        static let user = "User"
    }
    
    struct pucher {
        static let CLIENT_ID: Int = 883775
        static let CLIENT_SECRET: String = "c206ef6190ce7c3d68bc"
        static let CLIENT_KEY: String = "e4ac39499384d91f3784"
        static let CHATKIT_INSTANCE_LOCATOR: String = "CHATKIT_INSTANCE_LOCATOR"
        static let CLUSTER: String = "eu"
    }
}
