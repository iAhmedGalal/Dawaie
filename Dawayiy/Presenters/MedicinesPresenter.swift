//
//  MedicinesPresenter.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/20/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import Foundation

protocol MedicinesPresenterView: NSObjectProtocol {
    func setMedicines(_ medicines: [MedicinesData])
    func setLastPage(_ lastPage: Int)

    func setMedicinesFailure()


    func showConnectionErrorMessage()
}


class MedicinesPresenter {
    weak fileprivate var medicinesView : MedicinesPresenterView?
    fileprivate let postAPI = PostInteractors()

    init(_ hView: MedicinesPresenterView ){
        medicinesView = hView
    }
    
    init() {}
    
    func detachView() {
        medicinesView = nil
    }
    
    public func getMedicines(parameters: [String:Any]) {
        postAPI.getMedicines(parameters: parameters){ (response, error) in
            if error == nil {
                if(response?.status == true){
                    self.medicinesView?.setMedicines(response?.data?.data ?? [])
                    self.medicinesView?.setLastPage(response?.data?.last_page ?? 1)
                }else{
                    self.medicinesView?.setMedicinesFailure()
                }
            }else {
                self.medicinesView?.showConnectionErrorMessage()
            }
        }
    }

}
