//
//  SectionsVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/10/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class SectionsVC: UIViewController {
    @IBOutlet weak var sectionsCV: UICollectionView!
    
    var sectionsList: [SectionsData] = []
    
    fileprivate var presenter: SectionsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        initViews()
        
        presenter = SectionsPresenter(self)
        presenter?.getSections()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initViews() {
        sectionsCV.register(UINib.init(nibName: "DiseasesCell", bundle: nil), forCellWithReuseIdentifier: "DiseasesCell")
        sectionsCV.dataSource = self
        sectionsCV.delegate = self
    }


}

extension SectionsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiseasesCell", for: indexPath) as?
            DiseasesCell else {
                return UICollectionViewCell()
        }
        
        cell.configSectionsCell(item: sectionsList[indexPath.row])
        
        cell.title.addTarget(self, action: #selector(goToMedicines(_:)), for: UIControl.Event.touchUpInside)
        cell.title.tag = indexPath.row
        
        return cell
    }
    
    @objc func goToMedicines(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MedicinesVC") as! MedicinesVC
        vc.title = sectionsList[sender.tag].section_name ?? ""
        vc.seletedSectionId = String(sectionsList[sender.tag].id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SectionsVC: SectionsPresenterView {
    func setSections(_ sections: [SectionsData]) {
        sectionsList = sections
        sectionsCV.reloadData()
    }
    
    func setSectionsFailure() {}
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}
