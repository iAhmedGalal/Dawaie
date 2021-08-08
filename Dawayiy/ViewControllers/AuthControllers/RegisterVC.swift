//
//  RegisterVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/9/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class RegisterVC: UITableViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfirmTF: UITextField!
    @IBOutlet weak var check: CheckBox!
    
    fileprivate var presenter: SignupPresenter?
    
    var is_doctor: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupKeyboard()
        
        presenter = SignupPresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupKeyboard() {
        let toolbar = setupKeyboardToolbar()
        self.userNameTF.inputAccessoryView = toolbar
        self.phoneTF.inputAccessoryView = toolbar
        self.emailTF.inputAccessoryView = toolbar
        self.passwordTF.inputAccessoryView = toolbar
        self.passwordConfirmTF.inputAccessoryView = toolbar
    }
    
    @IBAction func termsBtn_tap(_ sender: Any) {
        let storyBoard = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PagesVC") as! PagesVC
        vc.title = "الشروط والأحكام"
        vc.pageTitle = "terms"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func registr_tap(_ sender: Any) {
        tableView.endEditing(true)

        if userNameTF.text == ""{
            Helper.showFloatAlert(title: "ادخل اسم المستخدم", subTitle: "", type: Constants.AlertType.AlertError)
        }else{
            if (phoneTF.text == ""){
                Helper.showFloatAlert(title: "ادخل رقم الجوال", subTitle: "", type: Constants.AlertType.AlertError)
            }else{
                if phoneTF.text?.prefix(2) != "05" ||  phoneTF.text!.count != 10 {
                    Helper.showFloatAlert(title: "رقم الجوال يجب أن يتكون من ١٠ أرقام ويبدأ ب05", subTitle: "", type: Constants.AlertType.AlertError)
                }else {
                    if(emailTF.text == ""){
                        Helper.showFloatAlert(title: "ادخل البريد الإلكتروني", subTitle: "", type: Constants.AlertType.AlertError)
                    }else{
                        if !Helper.isValidEmail(mail_address: emailTF.text ?? ""){
                            Helper.showFloatAlert(title: "ادخل بريد إلكتروني صحيح", subTitle: "", type: Constants.AlertType.AlertError)
                        }else {
                            if passwordTF.text == "" {
                                Helper.showFloatAlert(title: "ادخل كلمة المرور", subTitle: "", type: Constants.AlertType.AlertSuccess)
                            }else {
                                if passwordTF.text != passwordConfirmTF.text  {
                                    Helper.showFloatAlert(title: "كلمة المرور غير متطابقة", subTitle: "", type: Constants.AlertType.AlertError)
                                }else {
                                    registe()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func registe(){
        let player_id = "123-456-789"  //Helper.getUserDefault(key: Constants.userDefault.player_id) as! String

        if check.isChecked {
            is_doctor = 1
        }else {
            is_doctor = 0
        }
        
        let parameters = ["name": userNameTF.text ?? "",
                          "email": emailTF.text ?? "",
                          "mobile": phoneTF.text ?? "",
                          "player_id": player_id,
                          "is_doctor": is_doctor,
                          "password": passwordTF.text ?? "",
                          "password_confirmation": passwordConfirmTF.text ?? "" ] as [String : Any]
        
        presenter?.Signup(parameters: parameters)
    }
}

extension RegisterVC: SignupPresenterView {
    func getSignupSuccess(_ response: LoginData) {
        Helper.showFloatAlert(title: "تم إنشاء حساب جديد", subTitle: "", type: Constants.AlertType.AlertSuccess)

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
    
    func getSignupFailure(_ errors: [String]) {
        Helper.showFloatAlert(title: errors[0], subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }

}
