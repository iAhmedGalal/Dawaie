//
//  MyListVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/10/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class MyListVC: UIViewController {

    @IBOutlet weak var listCV: UICollectionView!
    
    var myMedicinesList: [MedicinesData] = []
    
    var searchPage: Int = 1
    var searchLastPage: Int = 1
    
    var listIndex: Int = 0
    
    var token: String = ""
    var userId: String = ""
    
    fileprivate var presenter: MyListPresenter?
    
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        token = Helper.getUserDefault(key: Constants.userDefault.userToken) as! String
        userId = Helper.getUserDefault(key: Constants.userDefault.userID) as! String
        
        initViews()
        
        presenter = MyListPresenter(self)
        
        showMyList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initViews() {
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshView), for: UIControl.Event.valueChanged)
        listCV.addSubview(refresher)
        
        listCV.register(UINib.init(nibName: "MyListCell", bundle: nil), forCellWithReuseIdentifier: "MyListCell")
        listCV.dataSource = self
        listCV.delegate = self
    }
    
    @objc func refreshView(){
        showMyList()
        refresher.endRefreshing()
    }
    
    func showMyList() {
        let parameters = ["user_id": userId,
                          "api_token": token,
                          "page": searchPage] as [String : Any]
        presenter?.getMyMedicines(parameters: parameters)
    }
   
}

extension MyListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 16) * 0.45, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myMedicinesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyListCell", for: indexPath) as?
            MyListCell else {
                return UICollectionViewCell()
        }
        
        cell.configCell(item: myMedicinesList[indexPath.row])
        
        if indexPath.row + 1 == myMedicinesList.count{
            if searchPage < searchLastPage {
                searchPage = searchPage + 1
                showMyList()
            }
        }
        
        cell.deleteBtn.addTarget(self, action: #selector(ShowDeleteDialog(_:)), for: UIControl.Event.touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MedicineDetailsVC") as! MedicineDetailsVC
        vc.title = myMedicinesList[indexPath.row].Drug_arabic_name ?? ""
        vc.medicineId = Int(myMedicinesList[indexPath.row].drug_id ?? "0") ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func ShowDeleteDialog(_ sender: UIButton) {
        listIndex = sender.tag
        let alert = UIAlertController(title: "حذف", message: "هل تريد حذف الدواء من قائمتي؟", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: removeMedicine))
        alert.addAction(UIAlertAction(title: "لأ", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func removeMedicine(alert: UIAlertAction!) {
        let parameters = ["user_id": userId,
                          "api_token": token,
                          "drug_id": myMedicinesList[listIndex].drug_id ?? 0] as [String : Any]
        presenter?.removeFromMyMedicines(parameters: parameters)
    }
}

extension MyListVC: MyListPresenterView {
    func setMedicines(_ medicines: [MedicinesData]) {
        var meds : [MedicinesData] = []
        meds = medicines
        
        if searchPage == 1{
            myMedicinesList.removeAll()
            myMedicinesList = meds
            listCV.reloadData()
        }else {
            myMedicinesList.append(contentsOf: meds)
            listCV.reloadData()
        }
    }
    
    func setLastPage(_ lastPage: Int) {
        searchLastPage = lastPage
    }
    
    func setMedicinesFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
        
    func getRemoveFromListSuccess(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertSuccess)
        myMedicinesList.remove(at: self.listIndex)
        listCV.reloadData()
    }
    
    func getRemoveFromListFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
    
}
