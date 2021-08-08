//
//  HomeVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/9/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController {
    
    @IBOutlet var homeTable: UITableView!
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var searchTextBtn: UIButton!
    
    @IBOutlet weak var medicineShapeBtn: UIButton!
    @IBOutlet weak var medicineColorBtn: UIButton!
    @IBOutlet weak var medicinePillDividesBtn: UIButton!

    @IBOutlet weak var medicineShapeCV: UICollectionView!
    @IBOutlet weak var medicineColorCV: UICollectionView!
    @IBOutlet weak var medicinePillDividesCV: UICollectionView!
    
    @IBOutlet weak var formsView: RoundRectView!
    @IBOutlet weak var colorsView: RoundRectView!
    @IBOutlet weak var dividesView: RoundRectView!
    
    var medicineShapeCellHight: CGFloat = 60
    var medicineColorCellHight: CGFloat = 0
    var medicinePillDividesCellHight: CGFloat = 0
    
    var shapeExpand: Bool = false
    var colorExpand: Bool = false
    var sectionExpand: Bool = false

    var token: String = ""
    var userId: String = ""
    
    fileprivate var presenter: HomePresenter?
    
    var formsList: [FormsData] = []
    var colorsList: [ColorsData] = []
    var dividesList: [DividesData] = []

    var selectedFormId: String = ""
    var selectedColorId: String = ""
    var seletedDivideId: String = ""
    
    var isFormSelected: Bool = false
    var isColorSelected: Bool = false
    var isDevideSelected: Bool = false

    
    var isColorAvailable: Int = 0
    var isDivideAvailable: Int = 0
    
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        token = Helper.getUserDefault(key: Constants.userDefault.userToken) as! String
        userId = Helper.getUserDefault(key: Constants.userDefault.userID) as! String
        print("token", token)
        print("userId", userId)

        initViews()
        
        presenter = HomePresenter(self)
        
        presenter?.getMedicineForms()
        presenter?.getMedicineColors()
        presenter?.getPillDivides()
        presenter?.setAppVisits()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func initViews() {
        setupKeyboard()
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshView), for: UIControl.Event.valueChanged)
        homeTable.addSubview(refresher)

        medicineShapeCV.register(UINib.init(nibName: "MedicineShapeCell", bundle: nil), forCellWithReuseIdentifier: "MedicineShapeCell")
        medicineColorCV.register(UINib.init(nibName: "MedicineShapeCell", bundle: nil), forCellWithReuseIdentifier: "MedicineShapeCell")
        medicinePillDividesCV.register(UINib.init(nibName: "MedicineShapeCell", bundle: nil), forCellWithReuseIdentifier: "MedicineShapeCell")
        
        medicineShapeCV.dataSource = self
        medicineShapeCV.delegate = self
        
        medicineColorCV.dataSource = self
        medicineColorCV.delegate = self
        
        medicinePillDividesCV.dataSource = self
        medicinePillDividesCV.delegate = self
    }
    
    func setupKeyboard() {
        let toolbar = setupKeyboardToolbar()
        self.searchText.inputAccessoryView = toolbar
    }
    
    @objc func refreshView(){
        medicineShapeCellHight = 60
        medicineColorCellHight = 0
        medicinePillDividesCellHight = 0
        
        shapeExpand = false
        colorExpand = false
        sectionExpand = false
        
        formsView.isHidden = true
        colorsView.isHidden = true
        dividesView.isHidden = true
        
        selectedFormId = ""
        selectedColorId = ""
        seletedDivideId = ""
        
        medicineShapeCV.reloadData()
        medicineColorCV.reloadData()
        medicinePillDividesCV.reloadData()
        
        homeTable.reloadData()
        
        refresher.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        
        if indexPath.row == 0 {
            height = 195
        }else if indexPath.row == 1 {
            height = 60
        }else if indexPath.row == 2{
            height = medicineShapeCellHight
        }else if indexPath.row == 3{
            height = medicineColorCellHight
        }else if indexPath.row == 4{
            height = medicinePillDividesCellHight
        }else if indexPath.row == 5{
            height = 60
        }else if indexPath.row == 6{
            height = 175
        }else if indexPath.row == 7{
            height = 175
        }
        
        return height
    }

    @IBAction func medicineShapeBtn_tapped(_ sender: Any) {
        cellsBackToDefault()
        colorExpand = false
        sectionExpand = false
        
        if shapeExpand {
            shapeExpand = false
            medicineShapeCellHight = 60
            formsView.isHidden = true
            homeTable.reloadData()
        }else {
            shapeExpand = true
            medicineShapeCellHight = 60 + CGFloat(formsList.count * 55)
            formsView.isHidden = false
            homeTable.reloadData()
        }
    }
    
    @IBAction func medicineColorBtn_tapped(_ sender: Any) {
        cellsBackToDefault()
        shapeExpand = false
        sectionExpand = false

        if colorExpand {
            colorExpand = false
            medicineColorCellHight = 60
            colorsView.isHidden = true
            homeTable.reloadData()
        }else {
            colorExpand = true
            medicineColorCellHight = 60 + CGFloat(colorsList.count * 55)
            colorsView.isHidden = false
            homeTable.reloadData()
        }
    }
    
    @IBAction func medicinePillDividesBtn_tapped(_ sender: Any) {
        cellsBackToDefault()
        shapeExpand = false
        colorExpand = false

        if sectionExpand {
            sectionExpand = false
            medicinePillDividesCellHight = 60
            dividesView.isHidden = true
            homeTable.reloadData()
        }else {
            sectionExpand = true
            medicinePillDividesCellHight = 60 + CGFloat(dividesList.count * 55)
            dividesView.isHidden = false
            homeTable.reloadData()
        }
    }
    
    @IBAction func searchBtn_tapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MedicinesVC") as! MedicinesVC
        vc.title = "نتائج البحث"
        vc.searchText = searchText.text ?? ""
        vc.selectedFormId = selectedFormId
        vc.selectedColorId = selectedColorId
        vc.seletedDivideId = seletedDivideId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func medicinesBtn_tapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MedicinesVC") as! MedicinesVC
        vc.title = "الأدوية"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func diseasesBtn_tapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DiseasesVC") as! DiseasesVC
        vc.title = "الأمراض"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func cellsBackToDefault() {
        medicineShapeCellHight = 60
        
        if isColorAvailable == 1 {
            medicineColorCellHight = 60
        }else {
            medicineColorCellHight = 0
        }
        
        if isDivideAvailable == 1 {
            medicinePillDividesCellHight = 60
        }else {
            medicinePillDividesCellHight = 0
        }
        
        formsView.isHidden = true
        colorsView.isHidden = true
        dividesView.isHidden = true
    }
    
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 50.0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case medicineShapeCV:
            return formsList.count
        case medicineColorCV:
            return colorsList.count
        case medicinePillDividesCV:
            return dividesList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case medicineShapeCV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicineShapeCell", for: indexPath) as?
                MedicineShapeCell else {
                    return UICollectionViewCell()
            }
            
            isFormSelected = false
            cell.configFormsCell(item: formsList[indexPath.row])
            cell.cellView.backgroundColor = UIColor.white

            return cell
            
        case medicineColorCV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicineShapeCell", for: indexPath) as?
                MedicineShapeCell else {
                    return UICollectionViewCell()
            }
            
            isColorSelected = false
            cell.configColorsCell(item: colorsList[indexPath.row])
            cell.cellView.backgroundColor = UIColor.white

            return cell
            
        case medicinePillDividesCV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicineShapeCell", for: indexPath) as?
                MedicineShapeCell else {
                    return UICollectionViewCell()
            }
            
            isDevideSelected = false
            cell.configDividesCell(item: dividesList[indexPath.row])
            cell.cellView.backgroundColor = UIColor.white
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case medicineShapeCV:
            guard let cell = medicineShapeCV.cellForItem(at: indexPath) as? MedicineShapeCell else {
                return
            }
            
            if isFormSelected == false {
                isFormSelected = true
                cell.cellView.backgroundColor = UIColor(red:0.48, green:0.66, blue:0.21, alpha:1.0)
                selectedFormId = String(formsList[indexPath.row].id ?? 0)
                isColorAvailable = Int(formsList[indexPath.row].color_choose ?? "0") ?? 0
                isDivideAvailable = Int(formsList[indexPath.row].pill_divide ?? "0") ?? 0
                
            }else {
                isFormSelected = false
                cell.cellView.backgroundColor = UIColor.white
                selectedFormId = ""
                isColorAvailable = 0
                isDivideAvailable = 0
            }

            if isColorAvailable == 1 {
                medicineColorCellHight = 60
                homeTable.reloadData()
            }else {
                medicineColorCellHight = 0
                homeTable.reloadData()
            }
            
            if isDivideAvailable == 1 {
                medicinePillDividesCellHight = 60
                homeTable.reloadData()
            }else {
                medicinePillDividesCellHight = 0
                homeTable.reloadData()
            }

        case medicineColorCV:
            guard let cell = medicineColorCV.cellForItem(at: indexPath) as? MedicineShapeCell else {
                return
            }
            
            if isColorSelected == false {
                isColorSelected = true
                cell.cellView.backgroundColor = UIColor(red:0.48, green:0.66, blue:0.21, alpha:1.0)
                selectedColorId = String(colorsList[indexPath.row].id ?? 0)
            }else {
                isColorSelected = false
                cell.cellView.backgroundColor = UIColor.white
                selectedColorId = ""
            }

        case medicinePillDividesCV:
            guard let cell = medicinePillDividesCV.cellForItem(at: indexPath) as? MedicineShapeCell else {
                return
            }
            
            if isDevideSelected == false {
                isDevideSelected = true
                cell.cellView.backgroundColor = UIColor(red:0.48, green:0.66, blue:0.21, alpha:1.0)
                seletedDivideId = String(dividesList[indexPath.row].id ?? 0)
            }else {
                isDevideSelected = false
                cell.cellView.backgroundColor = UIColor.white
                seletedDivideId = ""
            }
    
        default:
            print("Not Selected")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
        case medicineShapeCV:
            if let cell = medicineShapeCV.cellForItem(at: indexPath) as? MedicineShapeCell {
                cell.cellView.backgroundColor = UIColor.white
                isFormSelected = false
            }
            
        case medicineColorCV:
            if let cell = medicineColorCV.cellForItem(at: indexPath) as? MedicineShapeCell {
                cell.cellView.backgroundColor = UIColor.white
                isColorSelected = false
            }
            
        case medicinePillDividesCV:
            if let cell = medicinePillDividesCV.cellForItem(at: indexPath) as? MedicineShapeCell {
                cell.cellView.backgroundColor = UIColor.white
                isDevideSelected = false
            }

        default:
            print("Not Selected")
        }

    }
    
    
}

extension HomeVC: HomePresenterView {
    func setForms(_ forms: [FormsData]) {
        formsList = forms
        medicineShapeCV.reloadData()
    }
    
    func setColors(_ colors: [ColorsData]) {
        colorsList = colors
        medicineColorCV.reloadData()
    }
    
    func setDivides(_ divides: [DividesData]) {
        dividesList = divides
        medicinePillDividesCV.reloadData()
    }
    
    func setFormsFailure() {}
    
    func setColorFailure() {}
    
    func setDividesFailure() {}
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
}

