//
//  MyListPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//


import UIKit
import Foundation

protocol MyListPresenterView: NSObjectProtocol {
    func setMedicines(_ medicines: [MedicinesData])
    func setLastPage(_ lastPage: Int)

    func setMedicinesFailure(_ message: String)
    
    func getRemoveFromListSuccess(_ message: String)
    func getRemoveFromListFailure(_ message: String)


    func showConnectionErrorMessage()
}


class MyListPresenter {
    weak fileprivate var listView : MyListPresenterView?
    fileprivate let listAPI = MyListInteractors()

    init(_ hView: MyListPresenterView ){
        listView = hView
    }
    
    init() {}
    
    func detachView() {
        listView = nil
    }
    
    public func getMyMedicines(parameters: [String:Any]) {
        listAPI.getMyMedicines(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.listView?.setMedicines(response?.data?.data ?? [])
                    self.listView?.setLastPage(response?.data?.last_page ?? 1)
                }else{
                    self.listView?.setMedicinesFailure(response?.message ?? "")
                }
            }else {
                self.listView?.showConnectionErrorMessage()
            }
        }
    }
    
    public func removeFromMyMedicines(parameters: [String:Any]) {
        listAPI.removeFromMyList(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.listView?.getRemoveFromListSuccess(response?.message ?? "")
                }else{
                    self.listView?.getRemoveFromListFailure(response?.message ?? "")
                }
            }else {
                self.listView?.showConnectionErrorMessage()
            }
        }
    }

}
