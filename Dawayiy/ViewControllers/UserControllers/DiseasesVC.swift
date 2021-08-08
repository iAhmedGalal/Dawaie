//
//  DiseasesVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/10/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class DiseasesVC: UIViewController {
    
    @IBOutlet weak var itemsCV: UICollectionView!
    
    var diseasesList: [DiseasesData] = []
    
    fileprivate var presenter: DiseasesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        initViews()
        presenter = DiseasesPresenter(self)
        presenter?.getDiseases()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func initViews() {
        itemsCV.register(UINib.init(nibName: "DiseasesCell", bundle: nil), forCellWithReuseIdentifier: "DiseasesCell")
        
        itemsCV.dataSource = self
        itemsCV.delegate = self
    }
    
    
}

extension DiseasesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diseasesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiseasesCell", for: indexPath) as?
            DiseasesCell else {
                return UICollectionViewCell()
        }
        
        cell.configCell(item: diseasesList[indexPath.row])
        
        cell.title.addTarget(self, action: #selector(goToMedicines(_:)), for: UIControl.Event.touchUpInside)
        cell.title.tag = indexPath.row
        
        return cell
    }
    
    @objc func goToMedicines(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MedicinesVC") as! MedicinesVC
        vc.title = diseasesList[sender.tag].disease_name ?? ""
        vc.selectedDiseaseId = String(diseasesList[sender.tag].id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DiseasesVC: DiseasesPresenterView {
    func setDiseases(_ diseases: [DiseasesData]) {
        diseasesList = diseases
        itemsCV.reloadData()
    }
    
    func setDiseasesFailure() {}
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}

