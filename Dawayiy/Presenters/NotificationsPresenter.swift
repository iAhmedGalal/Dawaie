//
//  NotificationsPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 3/8/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//


import UIKit
import Foundation

protocol NotificationsPresenterView: NSObjectProtocol {
    func setNotifications(_ notification: [NotificationData])
    func setLastPage(_ lastPage: Int)

    func setNotificationsFailure(_ message: String)

    func showConnectionErrorMessage()
}


class NotificationsPresenter {
    weak fileprivate var notificationView : NotificationsPresenterView?
    fileprivate let getAPI = GetInteractors()

    init(_ hView: NotificationsPresenterView ){
        notificationView = hView
    }
    
    init() {}
    
    func detachView() {
        notificationView = nil
    }
    
    public func GetNotifications(page: String) {
        getAPI.GetNotifications(page: page){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.notificationView?.setNotifications(response?.data?.data ?? [])
                    self.notificationView?.setLastPage(response?.data?.last_page ?? 1)
                }else{
                    self.notificationView?.setNotificationsFailure(response?.message ?? "")
                }
            }else {
                self.notificationView?.showConnectionErrorMessage()
            }
        }
    }

}
