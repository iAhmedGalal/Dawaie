//
//  ContactsVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/11/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import MessageUI

class ContactsVC: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var messageTitleTF: UITextField!
    
    @IBOutlet weak var messageBodyTF: UITextView!
    
    fileprivate var presenter: SettingsPresenter?
    
    var siteEmail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupKeyboard()
        
        presenter = SettingsPresenter(self)
        presenter?.showSettings()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupKeyboard() {
        let messageBody_TFTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bodyTFDidBeginEditing))
        messageBodyTF.addGestureRecognizer(messageBody_TFTap)
        
        let toolbar = setupKeyboardToolbar()
        self.nameTF.inputAccessoryView = toolbar
        self.phoneTF.inputAccessoryView = toolbar
        self.emailTF.inputAccessoryView = toolbar
        self.messageTitleTF.inputAccessoryView = toolbar
        self.messageBodyTF.inputAccessoryView = toolbar
    }
    
    @objc func bodyTFDidBeginEditing() {
        self.messageBodyTF.becomeFirstResponder()
        
        if messageBodyTF.text == "اكتب رسالتك"{
            messageBodyTF.text = ""
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if messageTitleTF.text == "" {
            Helper.showFloatAlert(title: "ادخل عنوان الرسالة", subTitle: "", type: Constants.AlertType.AlertError)
        }else {
            if messageBodyTF.text == "" || messageBodyTF.text == "اكتب رسالتك" {
                Helper.showFloatAlert(title: "ادخل نص الرسالة", subTitle: "", type: Constants.AlertType.AlertError)
            }else {
                if nameTF.text == "" {
                    Helper.showFloatAlert(title: "ادخل اسم المستخدم", subTitle: "", type: Constants.AlertType.AlertError)
                }else{
                    if phoneTF.text == "" {
                        Helper.showFloatAlert(title: "ادخل رقم الجوال", subTitle: "", type: Constants.AlertType.AlertError)
                    }else{
                        if emailTF.text == "" {
                            Helper.showFloatAlert(title: "ادخل البريد الإلكتروني", subTitle: "", type: Constants.AlertType.AlertError)
                        }else{
                            sendEmail()
                        }
                    }
                }
            }
        }
    }
    
    func sendEmail() {
        let name = (nameTF.text ?? "") + " \n"
        let phone = name + (phoneTF.text ?? "") + " \n"
        let body = phone + (messageBodyTF.text ?? "")
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([siteEmail])
            mail.setSubject(messageTitleTF.text ?? "")
            mail.setMessageBody(body, isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}

extension ContactsVC: SettingsPresenterView {
    func setSettings(_ response: SettingsData) {
        siteEmail = response.email ?? ""
    }
    
    func setSettingsFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    
}
