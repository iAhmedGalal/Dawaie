//
//  ResetPasswordVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/12/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class ResetPasswordVC: UITableViewController {
    @IBOutlet weak var resetCode: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordConfirm: UITextField!
    
    fileprivate var presenter: ResetPasswordPresenter?

    var userId: Int = 0
    var userEmail: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        setupKeyboard()
        
        presenter = ResetPasswordPresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupKeyboard() {
        let toolbar = setupKeyboardToolbar()
        self.resetCode.inputAccessoryView = toolbar
        self.newPassword.inputAccessoryView = toolbar
        self.newPasswordConfirm.inputAccessoryView = toolbar
    }
    
    @IBAction func getNewPassword(_ sender: Any) {
        tableView.endEditing(true)
        
        if resetCode.text == "" {
            Helper.showFloatAlert(title: "ادخل الكود", subTitle: "", type: Constants.AlertType.AlertError)
        }else{
            if newPassword.text == ""{
                Helper.showFloatAlert(title: "ادخل كلمة المرور", subTitle: "", type: Constants.AlertType.AlertError)
            }else {
                if newPasswordConfirm.text == "" {
                    Helper.showFloatAlert(title: "ادخل تأكيد كلمة المرور", subTitle: "", type: Constants.AlertType.AlertError)
                }else {
                    if newPassword.text != newPasswordConfirm.text  {
                        Helper.showFloatAlert(title: "كلمة المرور غير متطابقة", subTitle: "", type: Constants.AlertType.AlertError)
                    }else {
                        ResetPassword()
                    }
                }
            }
        }
    }
    
    public func ResetPassword() {
        let player_id = "123-456-789"  //Helper.getUserDefault(key: Constants.userDefault.player_id) as! String

        let parameters = ["email": userEmail,
                          "active_code": resetCode.text ?? "",
                          "password": newPassword.text ?? "",
                          "password_confirmation": newPasswordConfirm.text ?? "",
                          "player_id": player_id] as [String : Any]
        presenter?.ResetPassword(parameters: parameters)
    }
}

extension ResetPasswordVC: ResetPasswordPresenterView {
    func getNewPasswordSuccess(_ response: LoginData) {
        Helper.showFloatAlert(title: "تم تغيير كلمة المرور", subTitle: "", type: Constants.AlertType.AlertSuccess)

        Helper.saveUserDefault(key: Constants.userDefault.userToken, value: response.api_token ?? "")
        
        Helper.saveUserDefault(key: Constants.userDefault.userID, value: "\(response.id ?? 0)")
        
        Helper.saveUserDefault(key: Constants.userDefault.userName, value: response.name ?? "")
        
        Helper.saveUserDefault(key: Constants.userDefault.userEmail, value: response.email ?? "")
        
        Helper.saveUserDefault(key: Constants.userDefault.userMobile, value: response.mobile ?? "")
        
        let mainSB = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
        let mainNV = mainSB.instantiateViewController(withIdentifier: "mainNC")
        mainNV.modalPresentationStyle = .fullScreen
        self.navigationController?.present(mainNV, animated: true, completion: nil)
    }
    
    func getNewPasswordFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}


