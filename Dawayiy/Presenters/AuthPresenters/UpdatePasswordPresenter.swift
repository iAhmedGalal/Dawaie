//
//  UpdatePasswordPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/23/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation

protocol UpdatePasswordPresenterView: NSObjectProtocol {
    func getUpdatePasswordSuccess(_ message: String)

    func getUpdatePasswordFailure(_ message: String)

    func showConnectionErrorMessage()
}

class UpdatePasswordPresenter {
    weak fileprivate var updatePasswordView: UpdatePasswordPresenterView?
    fileprivate let authAPI = AuthInteractors()
    
    init(_ uView: UpdatePasswordPresenterView) {
        updatePasswordView = uView
    }
    
    init() {}
    
    func detachView() {
        updatePasswordView = nil
    }

    public func ChangePassword(parameters: [String:Any]) {
        authAPI.updatePassword(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.updatePasswordView?.getUpdatePasswordSuccess(response?.message ?? "")
                }else{
                    self.updatePasswordView?.getUpdatePasswordFailure(response?.message ?? "")
                }
            }else {
                self.updatePasswordView?.showConnectionErrorMessage()
            }
        }
    }
    
}
