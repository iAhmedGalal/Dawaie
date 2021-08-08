//
//  HomePresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import Foundation

protocol HomePresenterView: NSObjectProtocol {
    func setForms(_ forms: [FormsData])
    func setFormsFailure()
    
    func setColors(_ colors: [ColorsData])
    func setColorFailure()
    
    func setDivides(_ divides: [DividesData])
    func setDividesFailure()

    func showConnectionErrorMessage()
}


class HomePresenter {
    weak fileprivate var homeView : HomePresenterView?
    fileprivate let getAPI = GetInteractors()

    init(_ hView: HomePresenterView ){
        homeView = hView
    }
    
    init() {}
    
    func detachView() {
        homeView = nil
    }
    
    public func getMedicineForms() {
        getAPI.getForms(){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.homeView?.setForms(response?.data ?? [])
                }else{
                    self.homeView?.setFormsFailure()
                }
            }else {
                self.homeView?.showConnectionErrorMessage()
            }
        }
    }
        
    public func getMedicineColors() {
        getAPI.getColors(){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.homeView?.setColors(response?.data ?? [])
                }else{
                    self.homeView?.setColorFailure()
                }
            }else {
                self.homeView?.showConnectionErrorMessage()
            }
        }
    }
    
    public func getPillDivides() {
        getAPI.getDivides(){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.homeView?.setDivides(response?.data ?? [])
                }else{
                    self.homeView?.setDividesFailure()
                }
            }else {
                self.homeView?.showConnectionErrorMessage()
            }
        }
    }
    
    public func setAppVisits() {
        getAPI.appVisits(){ (response, error) in
            if error == nil {
                if(response?.status == true){
                }else{
                }
            }else {
                self.homeView?.showConnectionErrorMessage()
            }
        }
    }
}
