//
//  DiseasesPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import Foundation

protocol DiseasesPresenterView: NSObjectProtocol {
    func setDiseases(_ diseases: [DiseasesData])
    func setDiseasesFailure()

    func showConnectionErrorMessage()
}


class DiseasesPresenter {
    weak fileprivate var diseasesView : DiseasesPresenterView?
    fileprivate let getAPI = GetInteractors()

    init(_ hView: DiseasesPresenterView ){
        diseasesView = hView
    }
    
    init() {}
    
    func detachView() {
        diseasesView = nil
    }
    
    public func getDiseases() {
        getAPI.getDiseases(){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.diseasesView?.setDiseases(response?.data ?? [])
                }else{
                    self.diseasesView?.setDiseasesFailure()
                }
            }else {
                self.diseasesView?.showConnectionErrorMessage()
            }
        }
    }

}
