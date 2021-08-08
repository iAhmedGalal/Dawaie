//
//  LoginVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/9/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class LoginVC: UITableViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    fileprivate var presenter: LoginPresenter?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        setupKeyboard()

        presenter = LoginPresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupKeyboard() {
        let toolbar = setupKeyboardToolbar()
        self.emailTF.inputAccessoryView = toolbar
        self.passwordTF.inputAccessoryView = toolbar
    }
    
    @IBAction func forgetPassword_tap(_ sender: Any) {
        let sb = UIStoryboard(name: Constants.storyBoard.authentication, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        vc.title = "نسيت كلمة المرور"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signup_tap(_ sender: Any) {
        let sb = UIStoryboard(name: Constants.storyBoard.authentication, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        vc.title = "إنشاء حساب جديد"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginTap(_ sender: Any) {
        tableView.endEditing(true)

        if emailTF.text == "" {
            Helper.showFloatAlert(title: "ادخل البريد الإلكتروني أو رقم الجوال", subTitle: "", type: Constants.AlertType.AlertSuccess)
        }else{
            if passwordTF.text == "" {
                Helper.showFloatAlert(title: "ادخل كلمة المرور", subTitle: "", type: Constants.AlertType.AlertSuccess)
            }else{
                login()
            }
        }
    }
    
    func login() {
        let player_id = "123-456-789" //Helper.getUserDefault(key: Constants.userDefault.player_id) as! String

        let parameters = ["email": emailTF.text ?? "",
                          "player_id": player_id,
                          "password": passwordTF.text ?? ""] as [String : Any]
        presenter?.Login(parameters: parameters)
    }

}

extension LoginVC: LoginPresenterView {
    func getLoginSuccess(_ response: LoginData) {
        Helper.showFloatAlert(title: "تم تسجيل الدخول بنجاح", subTitle: "", type: Constants.AlertType.AlertSuccess)
        
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
    
    func getLoginFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}
