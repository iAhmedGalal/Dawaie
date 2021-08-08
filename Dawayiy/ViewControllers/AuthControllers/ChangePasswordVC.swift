//
//  ChangePasswordVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/12/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class ChangePasswordVC: UITableViewController {
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var newPasswrdConfirmTF: UITextField!
    
    var token: String = ""
    var userId: String = ""
    
    fileprivate var presenter: UpdatePasswordPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        token = Helper.getUserDefault(key: Constants.userDefault.userToken) as! String
        userId = Helper.getUserDefault(key: Constants.userDefault.userID) as! String
        
        setupKeyboard()
        
        presenter = UpdatePasswordPresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupKeyboard() {
        let toolbar = setupKeyboardToolbar()
        self.oldPasswordTF.inputAccessoryView = toolbar
        self.newPasswordTF.inputAccessoryView = toolbar
        self.newPasswrdConfirmTF.inputAccessoryView = toolbar
    }
    
    @IBAction func updatePasswordBtn_tapped(_ sender: Any) {
        tableView.endEditing(true)
        
        if oldPasswordTF.text == "" {
            Helper.showFloatAlert(title: "ادخل كلمة المرور القديمة", subTitle: "", type: Constants.AlertType.AlertError)
        }else{
            if newPasswordTF.text == ""{
                Helper.showFloatAlert(title: "ادخل كلمة المرور الجديدة", subTitle: "", type: Constants.AlertType.AlertError)
            }else {
                if newPasswrdConfirmTF.text == "" {
                    Helper.showFloatAlert(title: "ادخل تأكيد كلمة المرور", subTitle: "", type: Constants.AlertType.AlertError)
                }else {
                    if newPasswordTF.text != newPasswrdConfirmTF.text  {
                        Helper.showFloatAlert(title: "كلمة المرور غير متطابقة", subTitle: "", type: Constants.AlertType.AlertError)
                    }else {
                        UpdatePassword()
                    }
                }
            }
        }
    }
    
    func UpdatePassword() {
        let parameters = ["api_token": token,
                          "user_id": userId,
                          "old_password": oldPasswordTF.text ?? "",
                          "password": newPasswordTF.text ?? "",
                          "password_confirmation": newPasswrdConfirmTF.text ?? ""] as [String : Any]
        presenter?.ChangePassword(parameters: parameters)
    }

}

extension ChangePasswordVC: UpdatePasswordPresenterView {
    func getUpdatePasswordSuccess(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertSuccess)
        
        let mainSB = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
        let mainNV = mainSB.instantiateViewController(withIdentifier: "mainNC")
        mainNV.modalPresentationStyle = .fullScreen
        self.navigationController?.present(mainNV, animated: true, completion: nil)
    }
    
    func getUpdatePasswordFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}
