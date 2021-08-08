//
//  OFCHelper.swift
//  OrangeFootballClub
//
//  Created by Zeinab Reda on 11/15/16.
//  Copyright © 2016 Alaa Taher. All rights reserved.
//

import UIKit
import SCLAlertView
import JDropDownAlert
import SideMenu
import Foundation

public extension UIImage {
    func base64Encode() -> String? {
        guard let imageData = self.pngData() else {
            return nil
        }
        
        let base64String = imageData.base64EncodedString()
        let fullBase64String = "data:image/png;base64,\(base64String))"
        
        return fullBase64String
    }
    
    func getCropRatio() -> CGFloat {
        let widthRatio = CGFloat(self.size.width / self.size.height)
        return widthRatio
    }
}

extension UITextView {
    func getHeight() -> CGFloat {
        let maximumLabelSize: CGSize = CGSize(width: 343, height: 99999)
        let expectedLabelSize: CGSize = self.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = self.frame
        newFrame.size.height = expectedLabelSize.height
        return newFrame.size.height
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func setupKeyboardToolbar() -> UIToolbar {
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "تم", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        return toolbar
    }
}

extension String {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}


extension UILabel{
    func underLine(){
        if let textUnwrapped = self.text{
            let underlineAttribute = [kCTUnderlineStyleAttributeName: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute as [NSAttributedString.Key : Any])
            self.attributedText = underlineAttributedString
        }
    }
}

extension UIAlertController {
    func changeFont(view:UIView,font:UIFont) {
        for item in view.subviews {
            if item is UICollectionView {
                let col = item as! UICollectionView
                for  row in col.subviews{
                    self.changeFont(view: row, font: font)
                }
            }
            if item is UILabel {
                let label = item as! UILabel
                label.font = font
            }else {
                self.changeFont(view: item, font: font)
            }
            
        }
    }
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //        let font =  UIFont(name: "GE SS", size: 16.0)!
        //        changeFont(view: self.view, font: font )
    }
}

class Helper: NSObject {
    
    static let userDef = UserDefaults.standard
    static let levelDic = NSDictionary(objects: ["Poussin","Minime","Cadet","Junior","Pro D2","Pro D1","Coach"], forKeys: [1 as NSCopying,2 as NSCopying,3 as NSCopying,4 as NSCopying,5 as NSCopying,6 as NSCopying,7 as NSCopying])
    
    
    static func goToLoginScreen(controller:UIViewController)
    {
        
        let storyBoard = UIStoryboard(name: Constants.storyBoard.authentication, bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC")
        controller.navigationController?.pushViewController(loginVC, animated: true)
    }
    /*
    static func convertDataToJson(data:Data) ->Any
    {
        var jsonDic : Any?
        do {
            jsonDic = try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions())
        }
        return jsonDic as Any
    }
    */

    
    static func showFloatAlert(title:String ,subTitle:String ,type:Int){

        let alert = JDropDownAlert()
        alert.alertWith(title)
        //        alert.titleFont = UIFont(name: "Helvetica", size: 20)!
        //        alert.messageFont = UIFont.italicSystemFont(ofSize: 12)

        if type == Constants.AlertType.AlertError
        {
            alert.alertWith(title, message: subTitle, topLabelColor: UIColor.white, messageLabelColor: UIColor.darkGray, backgroundColor: UIColor.red)
        }
        else if type == Constants.AlertType.AlertSuccess
        {
            alert.alertWith(title, message: subTitle, topLabelColor: UIColor.white, messageLabelColor: UIColor.darkGray, backgroundColor: UIColor(red:0.25, green:0.62, blue:0.81, alpha:1.0))

        }

        else if type == Constants.AlertType.AlertWarn
        {
            alert.alertWith(title, message: subTitle, topLabelColor: UIColor.white, messageLabelColor: UIColor.darkGray, backgroundColor: UIColor.yellow)

        }
        alert.didTapBlock = {
            //print("Top View Did Tapped")
        }
    }
    
    static func showAlert(type:Int,title:String,subTitle:String , closeTitle:String)
    {
        if type == Constants.AlertType.AlertError
        {
            SCLAlertView().showError(title, subTitle: subTitle, closeButtonTitle:closeTitle)
        }
        else if type == Constants.AlertType.AlertSuccess
        {
            SCLAlertView().showSuccess(title, subTitle: subTitle , closeButtonTitle:closeTitle)
        }
        else if type == Constants.AlertType.Alertinfo
        {
            SCLAlertView().showInfo(title, subTitle: subTitle , closeButtonTitle:closeTitle)
        }
        else if type == Constants.AlertType.AlertWarn
        {
            SCLAlertView().showWarning(title, subTitle: subTitle , closeButtonTitle:closeTitle)
            
        }
    }
    static func saveUserDefault(key:String,value:Any)
    {
        userDef.set(value, forKey: key)
    }
    
    static func getUserDefault(key:String)->Any
    {
        return userDef.string(forKey: key) ?? ""
    }
    
    static func removeKeyUserDefault(key:String)
    {
        userDef.removeObject(forKey: key)
        userDef.synchronize()
    }
    
    static func getCurrentLang()-> String
    {
        if let lang =  Helper.getUserDefault(key: "language") as? String
        {
            return lang
        }
        return "en"
    }
    
    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return userDef.object(forKey: key) != nil
    }
    
    
    static func setupSideMenue(nav:UINavigationController) {
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.width - 50
        SideMenuManager.default.menuAddPanGestureToPresent(toView: nav.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: nav.view)
        SideMenuManager.default.menuFadeStatusBar = false
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    static func shareNews(text:String,img:UIImage,vc:UIViewController)
    {
        
        // set up activity view controller
        let Share = [text,img] as [Any]
        let activityViewController = UIActivityViewController(activityItems: Share, applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = vc.view // so that iPOffersData won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
        
        // present the view controller
        vc.present(activityViewController, animated: true, completion: nil)
    }
    static func shareApp(appUrl:String,vc:UIViewController)
    {
        
        // set up activity view controller
        let url = URL(string: appUrl)
        let Share = [url!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: Share, applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = vc.view // so that iPOffersData won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
        
        // present the view controller
        vc.present(activityViewController, animated: true, completion: nil)
    }
    
    static func setupKeyboardHeight()  -> Int {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5 or 5S or 5C")
            return -275
        case 1334:
            print("iPhone 6/6S/7/8")
            return -275
        case 1920, 2208:
            print("iPhone 6+/6S+/7+/8+")
            return -275
        case 2436:
            print("iPhone X, XS")
            return -315
        case 2688:
            print("iPhone XS Max")
            return -315
        case 1792:
            print("iPhone XR")
            return -315
        default:
            return -315
        }
    }
    
    static func animateTable(table:UITableView) {
        table.reloadData()
        
        let cells = table.visibleCells
        let tableHeight: CGFloat = table.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay:  0.05 * Double(index) , usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
    static func openUrl(urlStr:String)
    {
        let url = URL(string: urlStr)!
        UIApplication.shared.openURL(url as URL)
    }
    
    static func getImageWithSize(urlStr:String,originalSize:String,updateSize:String)->String
    {//"20x14"
        let flag = urlStr.replacingOccurrences(of: originalSize, with: updateSize, options: .literal, range: nil)
        return flag
    }
    
    static func isValidEmail(mail_address:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: mail_address)
    }
    
    static func isValidPhone(phone:String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phone.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phone == filtered
    }
    
    static func numberToLocale(number : String, localeIdentifier: String) -> NSNumber? {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: localeIdentifier)
        guard let resultNumber = numberFormatter.number(from: number) else{
            return NSNumber(pointer: number)
        }
        return resultNumber
    }
    
    static func getCountryCode(phone:String) -> String {
        var phoneNumber:String = phone
        if phone.first == "0" {
            phoneNumber =  phone.replacingOccurrences(of: "0", with: "")
        }
        if phone.first == "+" {
            phoneNumber =  phone.replacingOccurrences(of: "+", with: "")
        }
        
        let start = phoneNumber.index(phoneNumber.startIndex, offsetBy: phoneNumber.count - 10)
        let end = phoneNumber.index(phoneNumber.endIndex, offsetBy: 0)
        let range = start..<end
        
        return phoneNumber.substring(with: range)
    }
    
    static func pushToViewController(stroyBoardName:String,controllerIdentifier:String,navController:UINavigationController)
    {
        let accountStoryBoard = UIStoryboard(name: stroyBoardName, bundle: nil)
        let controller = accountStoryBoard.instantiateViewController(withIdentifier: controllerIdentifier)
        navController.pushViewController(controller, animated: true)
    }
    static func presentViewController(stroyBoardName:String,controllerIdentifier:String,viewController:UIViewController)
    {
        let accountStoryBoard = UIStoryboard(name: stroyBoardName, bundle: nil)
        let controller = accountStoryBoard.instantiateViewController(withIdentifier: controllerIdentifier)
        viewController.present(controller, animated: true, completion: nil)
    }
    
    static func format(phoneNumber sourcePhoneNumber: String) -> String? {
        // Remove any character that is not a number
        let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.count
        let hasLeadingOne = numbersOnly.hasPrefix("1")
        // Check for supported phone number length
        guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
            return nil
        }
        let hasAreaCode = (length >= 10)
        var sourceIndex = 0
        // Leading 1
        var leadingOne = ""
        if hasLeadingOne {
            leadingOne = "1 "
            sourceIndex += 1
        }
        /*
        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return nil
            }
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }
        
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return nil
        }
        sourceIndex += prefixLength
        
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return nil
        }
        */
        
        return leadingOne //leadingOne + areaCode + prefix + "-" + suffix
    }
 
    static func callNumber(phone_number:String)
    {
        if let url = URL(string: "tel://\(phone_number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static public func getTopViewController() -> UIViewController? {
        
        if var topViewController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            }
            
            return topViewController
        }
        
        return nil
    }
}

