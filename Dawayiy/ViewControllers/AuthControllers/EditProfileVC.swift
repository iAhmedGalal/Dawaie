//
//  EditProfileVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/12/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class EditProfileVC: UITableViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    var token: String = ""
    var userId: String = ""
    var name: String = ""
    var email: String = ""
    var phone: String = ""

    fileprivate var presenter: ProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        token = Helper.getUserDefault(key: Constants.userDefault.userToken) as! String
        userId = Helper.getUserDefault(key: Constants.userDefault.userID) as! String
        name = Helper.getUserDefault(key: Constants.userDefault.userName) as! String
        email = Helper.getUserDefault(key: Constants.userDefault.userEmail) as! String
        phone = Helper.getUserDefault(key: Constants.userDefault.userMobile) as! String
        
        setupKeyboard()
        
        presenter = ProfilePresenter(self)
        GetProfileData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupKeyboard() {
        let toolbar = setupKeyboardToolbar()
        self.userNameTF.inputAccessoryView = toolbar
        self.phoneTF.inputAccessoryView = toolbar
        self.emailTF.inputAccessoryView = toolbar
    }
    
    func GetProfileData() {
        userNameTF.text = name
        emailTF.text = email
        phoneTF.text = phone
    }
    
    @IBAction func chabgePasswordBtn_tapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: Constants.storyBoard.authentication, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        vc.title = "كلمة مرور جديدة"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func updateProfileBtn_taped(_ sender: Any) {
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
                            updateProfile()
                        }
                    }
                }
            }
        }
    }
    
    func updateProfile(){
        let parameters = ["api_token": token,
                          "user_id": userId,
                          "name": userNameTF.text ?? "",
                          "email": emailTF.text ?? "",
                          "mobile": phoneTF.text ?? ""] as [String : Any]
        
        presenter?.updateProfile(parameters: parameters)
    }
    
}

extension EditProfileVC: ProfilePresenterView {
    func getUpdateProfileSuccess(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertSuccess)
        
        Helper.saveUserDefault(key: Constants.userDefault.userName, value: userNameTF.text ?? "")
        
        Helper.saveUserDefault(key: Constants.userDefault.userEmail, value: emailTF.text ?? "")
        
        Helper.saveUserDefault(key: Constants.userDefault.userMobile, value: phoneTF.text ?? "")
        
        let mainSB = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
        let mainNV = mainSB.instantiateViewController(withIdentifier: "mainNC")
        mainNV.modalPresentationStyle = .fullScreen
        self.navigationController?.present(mainNV, animated: true, completion: nil)
    }
    
    func getUpdateProfileFailure(_ error: [String]) {
        Helper.showFloatAlert(title: error[0], subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
    
}
