//
//  SignupPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/16/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation

protocol SignupPresenterView: NSObjectProtocol {
    func getSignupSuccess(_ response: LoginData)

    func getSignupFailure(_ errors: [String])

    func showConnectionErrorMessage()
}

class SignupPresenter {
    weak fileprivate var SignupView: SignupPresenterView?
    fileprivate let authAPI = AuthInteractors()
    
    init(_ lView: SignupPresenterView) {
        SignupView = lView
    }
    
    init() {}
    
    func detachView() {
        SignupView = nil
    }

    public func Signup(parameters: [String:Any]) {
        authAPI.signup(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.SignupView?.getSignupSuccess((response?.user)!)
                }else{
                    self.SignupView?.getSignupFailure(response?.error ?? [])
                }
            }else {
                self.SignupView?.showConnectionErrorMessage()
            }
        }
    }
    
}
