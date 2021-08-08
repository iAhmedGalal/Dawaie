//
//  ForgetPasswordVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/12/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UITableViewController {
    @IBOutlet weak var emailTF: UITextField!
    
    fileprivate var presenter: ForgetPasswordPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupKeyboard()
        
        presenter = ForgetPasswordPresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupKeyboard() {
        let toolbar = setupKeyboardToolbar()
        self.emailTF.inputAccessoryView = toolbar
    }
    
    @IBAction func sendResetCode_tap(_ sender: Any) {
        tableView.endEditing(true)
        if emailTF.text == "" {
            Helper.showFloatAlert(title: "ادخل البريد الإلكتروني" , subTitle: "", type: Constants.AlertType.AlertError)
        }else{
            resetCode()
        }
    }
    
    public func resetCode() {
        let parameters = ["email": emailTF.text ?? ""] as [String : Any]
        presenter?.SendResetCode(parameters: parameters)
    }
}

extension ForgetPasswordVC: ForgetPasswordPresenterView {
    func getResetPasswordSuccess(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertSuccess)
    }
    
    func getUserIdSuccess(_ userId: Int) {
        let story = UIStoryboard(name: Constants.storyBoard.authentication, bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ResetPasswordVC") as!  ResetPasswordVC
        vc.title = "استعادة كلمة المرور"
        vc.userId = userId
        vc.userEmail = emailTF.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAdvertiserIdSuccess(_ advertiserId: Int) {

    }
    
    func getResetPasswordFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}
