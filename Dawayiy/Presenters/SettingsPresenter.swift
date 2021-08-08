//
//  SettingsPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/23/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import Foundation

protocol SettingsPresenterView: NSObjectProtocol {
    func setSettings(_ response: SettingsData)
    func setSettingsFailure(_ message: String)
    
    func showConnectionErrorMessage()
}


class SettingsPresenter {
    weak fileprivate var settingsView : SettingsPresenterView?
    fileprivate let getAPI = GetInteractors()
    
    init(_ hView: SettingsPresenterView ){
        settingsView = hView
    }
    
    init() {}
    
    func detachView() {
        settingsView = nil
    }
    
    public func showSettings() {
        getAPI.getSettings(){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.settingsView?.setSettings((response?.data)!)
                }else{
                    self.settingsView?.setSettingsFailure(response?.message ?? "")
                }
            }else {
                self.settingsView?.showConnectionErrorMessage()
            }
        }
    }
    
}
