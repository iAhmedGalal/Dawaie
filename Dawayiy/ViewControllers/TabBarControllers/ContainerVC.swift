//
//  ContainerVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/13/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var sectionsBtn: UIButton!
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var myListBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var sectionsLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var myListLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    
    var isProfileOpen: Bool = false
    var isSectionsOpen: Bool = false
    var isHomeOpen: Bool = false
    var isMyListOpen: Bool = false
    var isMenuOpen: Bool = false
    
    var textColor = UIColor(red:0.48, green:0.66, blue:0.21, alpha:1.0)

    // MARK: - Declare Viewcontrollers

    private lazy var LoginViewController: LoginVC = {
        let storyboard = UIStoryboard(name: Constants.storyBoard.authentication, bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        return viewController
    }()
    
    private lazy var ProfileViewController: EditProfileVC = {
        let storyboard = UIStoryboard(name: Constants.storyBoard.authentication, bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        return viewController
    }()

    private lazy var SectionsViewController: SectionsVC = {
        let storyboard = UIStoryboard(name: Constants.storyBoard.main, bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SectionsVC") as! SectionsVC
        return viewController
    }()
    
    private lazy var HomeViewController: HomeVC = {
        let storyboard = UIStoryboard(name: Constants.storyBoard.main, bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        return viewController
    }()

    private lazy var MyListViewController: MyListVC = {
        let storyboard = UIStoryboard(name: Constants.storyBoard.main, bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "MyListVC") as! MyListVC
        return viewController
    }()
    
    private lazy var MenuViewController: MenuVC = {
        let storyboard = UIStoryboard(name: Constants.storyBoard.main, bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        return viewController
    }()
    
    
    // MARK: - View Load

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        mainLabel.textColor = textColor
        mainBtn.setImage(UIImage(named: "menuhomegreen"), for: .normal)
        
        if Helper.isKeyPresentInUserDefaults(key: Constants.userDefault.userToken){
            profileLabel.text = "بياناتي"
        }else{
            profileLabel.text = "دخول"
        }

        add(childViewController: HomeViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - ContainerView Methods

    private func add(childViewController: UIViewController) {
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        childViewController.view.frame = containerView.bounds
        containerView.addSubview(childViewController.view)
    }
    
    private func remove(childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }

    // MARK: - Botton Taps Methods
    
    @IBAction func profileBtn_tapped(_ sender: Any) {
        resetTabsToDefaults()
        profileLabel.textColor = textColor
        profileBtn.setImage(UIImage(named: "menuprofilegreen"), for: .normal)
        if Helper.isKeyPresentInUserDefaults(key: Constants.userDefault.userToken){
            add(childViewController: ProfileViewController)
        }else {
            add(childViewController: LoginViewController)
        }
    }
    
    @IBAction func sectionsBtn_tapped(_ sender: Any) {
        resetTabsToDefaults()
        sectionsLabel.textColor = textColor
        sectionsBtn.setImage(UIImage(named: "menusectionsgreen"), for: .normal)
        add(childViewController: SectionsViewController)
    }
    
    @IBAction func mainBtn_tapped(_ sender: Any) {
        resetTabsToDefaults()
        mainLabel.textColor = textColor
        mainBtn.setImage(UIImage(named: "menuhomegreen"), for: .normal)
        add(childViewController: HomeViewController)
    }
    
    @IBAction func myListBtn_tapped(_ sender: Any) {
        resetTabsToDefaults()
        myListLabel.textColor = textColor
        myListBtn.setImage(UIImage(named: "menumylistgreen"), for: .normal)
        add(childViewController: MyListViewController)
    }
    
    @IBAction func moreBtn_tapped(_ sender: Any) {
        resetTabsToDefaults()
        moreLabel.textColor = textColor
        moreBtn.setImage(UIImage(named: "menumoregreen"), for: .normal)
        add(childViewController: MenuViewController)
    }
    
    func resetTabsToDefaults() {
        profileLabel.textColor = UIColor.lightGray
        sectionsLabel.textColor = UIColor.lightGray
        mainLabel.textColor = UIColor.lightGray
        myListLabel.textColor = UIColor.lightGray
        moreLabel.textColor = UIColor.lightGray
        
        profileBtn.setImage(UIImage(named: "menuprofile"), for: .normal)
        sectionsBtn.setImage(UIImage(named: "menusections"), for: .normal)
        mainBtn.setImage(UIImage(named: "grouphome"), for: .normal)
        myListBtn.setImage(UIImage(named: "menumylist"), for: .normal)
        moreBtn.setImage(UIImage(named: "menumore"), for: .normal)
    }

}
