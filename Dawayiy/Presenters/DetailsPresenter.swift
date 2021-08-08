//
//  DetailsPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import Foundation

protocol DetailsPresenterView: NSObjectProtocol {
    func getMedicineDetailsSuccess(_ medicine: DetailsData)
    func getMedicineDetailsFailure(_ message: String)
    
    func getAddToListSuccess(_ message: String)
    func getAddToListFailure(_ message: String)

    func getRemoveFromListSuccess(_ message: String)
    func getRemoveFromListFailure(_ message: String)

    func showConnectionErrorMessage()
}


class DetailsPresenter {
    weak fileprivate var detailsView : DetailsPresenterView?
    fileprivate let postAPI = PostInteractors()
    fileprivate let listAPI = MyListInteractors()

    init(_ hView: DetailsPresenterView ){
        detailsView = hView
    }
    
    init() {}
    
    func detachView() {
        detailsView = nil
    }
    
    public func getDetails(parameters: [String:Any]) {
        postAPI.getMedicineDetails(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.detailsView?.getMedicineDetailsSuccess((response?.data)!)
                }else{
                    self.detailsView?.getMedicineDetailsFailure(response?.message ?? "")
                }
            }else {
                self.detailsView?.showConnectionErrorMessage()
            }
        }
    }
    
    public func addToMyMedicines(parameters: [String:Any]) {
        listAPI.addToMyList(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.detailsView?.getAddToListSuccess(response?.message ?? "")
                }else{
                    self.detailsView?.getAddToListFailure(response?.message ?? "")
                }
            }else {
                self.detailsView?.showConnectionErrorMessage()
            }
        }
    }
    
    public func removeFromMyMedicines(parameters: [String:Any]) {
        listAPI.removeFromMyList(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.detailsView?.getRemoveFromListSuccess(response?.message ?? "")
                }else{
                    self.detailsView?.getRemoveFromListFailure(response?.message ?? "")
                }
            }else {
                self.detailsView?.showConnectionErrorMessage()
            }
        }
    }

}
