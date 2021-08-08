//
//  ProfilePresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation
import UIKit

protocol ProfilePresenterView: NSObjectProtocol {
    func getUpdateProfileSuccess(_ message: String)
    func getUpdateProfileFailure(_ error: [String])

    func showConnectionErrorMessage()
}

class ProfilePresenter {
    weak fileprivate var profileView: ProfilePresenterView?
    fileprivate let authAPI = AuthInteractors()

    init(_ lView: ProfilePresenterView) {
        profileView = lView
    }
    
    init() {}
    
    func detachView() {
        profileView = nil
    }
    
    public func updateProfile(parameters: [String:Any]) {
        authAPI.saveUserInfo(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.profileView?.getUpdateProfileSuccess(response?.message ?? "")
                }else{
                    self.profileView?.getUpdateProfileFailure(response?.error ?? [])
                }
            }else {
                self.profileView?.showConnectionErrorMessage()
            }
        }
    }
    

    
}
