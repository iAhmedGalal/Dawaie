//
//  ResetPasswordPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation

protocol ResetPasswordPresenterView: NSObjectProtocol {
    func getNewPasswordSuccess(_ response: LoginData)

    func getNewPasswordFailure(_ message: String)

    func showConnectionErrorMessage()
}

class ResetPasswordPresenter {
    weak fileprivate var resetPasswordView: ResetPasswordPresenterView?
    fileprivate let authAPI = AuthInteractors()
    
    init(_ uView: ResetPasswordPresenterView) {
        resetPasswordView = uView
    }
    
    init() {}
    
    func detachView() {
        resetPasswordView = nil
    }

    public func ResetPassword(parameters: [String:Any]) {
        authAPI.getNewPassword(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.resetPasswordView?.getNewPasswordSuccess((response?.data)!)
                }else{
                    self.resetPasswordView?.getNewPasswordFailure(response?.message ?? "")
                }
            }else {
                self.resetPasswordView?.showConnectionErrorMessage()
            }
        }
    }
    
}
