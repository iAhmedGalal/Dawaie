//
//  MenuVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/9/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    var token: String = ""
    var userId: String = ""
    
    fileprivate let authAPI = AuthInteractors()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        token = Helper.getUserDefault(key: Constants.userDefault.userToken) as! String
        userId = Helper.getUserDefault(key: Constants.userDefault.userID) as! String
        
        let backgroundImage = UIImage(named: "background")
        let imageViewTB = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageViewTB

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        
        switch indexPath.row {
        case 0:
            height = 195
            
        case 1, 5:
            if Helper.isKeyPresentInUserDefaults(key: Constants.userDefault.userToken){
                height = 70
            }else {
                height = 0
            }

        default:
            height = 70
        }
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 { //notifications
            let storyBoard = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
            vc.title = "الإشعارات"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 2 { //about
            let storyBoard = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PagesVC") as! PagesVC
            vc.title = "من نحن"
            vc.pageTitle = "about"
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
        else if indexPath.row == 3 { //terms
            let storyBoard = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PagesVC") as! PagesVC
            vc.title = "الشروط والأحكام"
            vc.pageTitle = "terms"
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
        else if indexPath.row == 4 { //contactus
            let storyBoard = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ContactsVC") as! ContactsVC
            vc.title = "اتصل بنا"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 5 { // logout
            Helper.removeKeyUserDefault(key: Constants.userDefault.userToken)
            Helper.removeKeyUserDefault(key: Constants.userDefault.userID)
            Helper.removeKeyUserDefault(key: Constants.userDefault.userName)
            Helper.removeKeyUserDefault(key: Constants.userDefault.userEmail)
            Helper.removeKeyUserDefault(key: Constants.userDefault.userMobile)
            Helper.removeKeyUserDefault(key: Constants.userDefault.activeStatus)
            
            let parameters = ["api_token": token, "user_id": userId] as [String : Any]
            authAPI.logout(parameters: parameters){ (response, error) in }

            let mainSB = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
            let mainNV = mainSB.instantiateViewController(withIdentifier: "mainNC")
            mainNV.modalPresentationStyle = .fullScreen
            self.navigationController?.present(mainNV, animated: true, completion: nil)
            
        }

    }

}
