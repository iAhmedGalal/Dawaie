//
//  PagesVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/11/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class PagesVC: UITableViewController {
    
    @IBOutlet var pagesTable: UITableView!
    @IBOutlet weak var pageContent: UITextView!
    
    fileprivate var presenter: SettingsPresenter?
    
    var contentCellHeight: CGFloat = 0
    
    var pageTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        presenter = SettingsPresenter(self)
        presenter?.showSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        height = contentCellHeight
        return height
    }
    
}

extension PagesVC: SettingsPresenterView {
    func setSettings(_ response: SettingsData) {
        if pageTitle == "about" {
            pageContent.text = response.about_app ?? ""
        }else if pageTitle == "terms" {
            pageContent.text = response.terms_of_use ?? ""
        }
        
        contentCellHeight = pageContent.getHeight() + 20
        pagesTable.reloadData()
    }
    
    func setSettingsFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
    
}

