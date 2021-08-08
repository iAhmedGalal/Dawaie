//
//  NotificationsVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/11/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController {
    
    @IBOutlet weak var notificationsCV: UICollectionView!
    
    var notificationsList: [NotificationData] = []
    
    fileprivate var presenter: NotificationsPresenter?
    
    var nPage: Int = 1
    var nLastPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        initViews()
        
        presenter = NotificationsPresenter(self)
        ShowNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func initViews() {
        notificationsCV.register(UINib.init(nibName: "NotificationsCell", bundle: nil), forCellWithReuseIdentifier: "NotificationsCell")
        
        notificationsCV.dataSource = self
        notificationsCV.delegate = self
    }
    
    func ShowNotification() {
        presenter?.GetNotifications(page: "\(nPage)")
    }
    
    
}

extension NotificationsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificationsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationsCell", for: indexPath) as?
            NotificationsCell else {
                return UICollectionViewCell()
        }
        
        cell.configCell(item: notificationsList[indexPath.row])
        
        if indexPath.row + 1 == notificationsList.count{
            if nPage < nLastPage {
                nPage = nPage + 1
                ShowNotification()
            }
        }
        
        return cell
        
    }
    
    
}

extension NotificationsVC: NotificationsPresenterView {
    func setNotifications(_ notification: [NotificationData]) {
        var nots : [NotificationData] = []
        nots = notification
        
        if nPage == 1{
            notificationsList.removeAll()
            notificationsList = nots
            notificationsCV.reloadData()
        }else {
            notificationsList.append(contentsOf: nots)
            notificationsCV.reloadData()
        }
    }
    
    func setLastPage(_ lastPage: Int) {
        nLastPage = lastPage
    }
    
    func setNotificationsFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}

