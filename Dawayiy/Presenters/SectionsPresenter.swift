//
//  SectionsPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import Foundation

protocol SectionsPresenterView: NSObjectProtocol {
    func setSections(_ sections: [SectionsData])
    func setSectionsFailure()

    func showConnectionErrorMessage()
}


class SectionsPresenter {
    weak fileprivate var sectionView : SectionsPresenterView?
    fileprivate let getAPI = GetInteractors()

    init(_ hView: SectionsPresenterView ){
        sectionView = hView
    }
    
    init() {}
    
    func detachView() {
        sectionView = nil
    }
    
    public func getSections() {
        getAPI.getSections(){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.sectionView?.setSections(response?.data ?? [])
                }else{
                    self.sectionView?.setSectionsFailure()
                }
            }else {
                self.sectionView?.showConnectionErrorMessage()
            }
        }
    }

}
