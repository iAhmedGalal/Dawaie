//
//  MedicineDetailsVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/11/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class MedicineDetailsVC: UITableViewController {
    @IBOutlet var detailsTable: UITableView!
    
    @IBOutlet weak var diseasesCV: UICollectionView!
    
    @IBOutlet weak var medicineImage: UIImageView!
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var medicineSection: UILabel!

    @IBOutlet weak var infoTV: UITextView!
    @IBOutlet weak var activeSubstancesTV: UITextView!
    @IBOutlet weak var instructionsTV: UITextView!
    @IBOutlet weak var sideEffectsTV: UITextView!
    @IBOutlet weak var warningsTV: UITextView!
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var activeSubstancesImage: UIImageView!
    @IBOutlet weak var instructionsImage: UIImageView!
    @IBOutlet weak var sideEffectsImage: UIImageView!
    @IBOutlet weak var warningsImage: UIImageView!
    @IBOutlet weak var treatedDiseasesImage: UIImageView!
    
    @IBOutlet weak var addToMyListBtn: UIButton!

    var infoCellHeight: CGFloat = 60
    var activeSubstancesCellHeight: CGFloat = 60
    var instructionsCellHeight: CGFloat = 60
    var sideEffectsCellHeight: CGFloat = 60
    var warningsCellHeight: CGFloat = 60
    var treatedDiseasesCellHeight: CGFloat = 60
    
    var isInfoOpen: Bool = false
    var isActiveSubstancesOpen: Bool = false
    var isInstructionsOpen: Bool = false
    var isSideEffectsOpen: Bool = false
    var isWarningsOpen: Bool = false
    var isTreatedDiseasesOpen: Bool = false
    
    var medicineId: Int = 0
    var inMyList: Int = 0
    
    var token: String = ""
    var userId: String = ""
    
    var diseasesList: [Drug_diseases] = []
    
    fileprivate var presenter: DetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        token = Helper.getUserDefault(key: Constants.userDefault.userToken) as! String
        userId = Helper.getUserDefault(key: Constants.userDefault.userID) as! String
        
        initViews()
        
        presenter = DetailsPresenter(self)
        
        ShowMedicineDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func ShowMedicineDetails() {
        let parameters = ["api_token": token,
                          "user_id": userId,
                          "drug_id": medicineId] as [String : Any]
        presenter?.getDetails(parameters: parameters)
    }
    
    func cellsBackToDefault() {
        infoCellHeight = 60
        activeSubstancesCellHeight = 60
        instructionsCellHeight = 60
        sideEffectsCellHeight = 60
        warningsCellHeight = 60
        treatedDiseasesCellHeight = 60
        
        infoImage.image = UIImage(named: "downarrowgreen")
        activeSubstancesImage.image = UIImage(named: "downarrowgreen")
        instructionsImage.image = UIImage(named: "downarrowgreen")
        sideEffectsImage.image = UIImage(named: "downarrowgreen")
        warningsImage.image = UIImage(named: "downarrowgreen")
        treatedDiseasesImage.image = UIImage(named: "downarrowgreen")
    }

    // MARK: - Table view data source
    
    func initViews() {
        diseasesCV.register(UINib.init(nibName: "LettersCell", bundle: nil), forCellWithReuseIdentifier: "LettersCell")
        diseasesCV.dataSource = self
        diseasesCV.delegate = self
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        
        switch indexPath.row {
        case 1:
            height = infoCellHeight
        case 2:
            height = activeSubstancesCellHeight
        case 3:
            height = instructionsCellHeight
        case 4:
            height = sideEffectsCellHeight
        case 5:
            height = warningsCellHeight
        case 6:
            height = treatedDiseasesCellHeight
        default:
            height = 365
        }
        
        return height
    }
    
    @IBAction func addToMyListBtn_tapped(_ sender: Any) {
        let parameters = ["api_token": token,
                          "user_id": userId,
                          "drug_id": medicineId] as [String : Any]
        if inMyList == 1 {
            presenter?.removeFromMyMedicines(parameters: parameters)
        }else{
            presenter?.addToMyMedicines(parameters: parameters)
        }
    }
    
    @IBAction func infoBtn_tapped(_ sender: Any) {
        cellsBackToDefault()
        
        isActiveSubstancesOpen = false
        isInstructionsOpen = false
        isSideEffectsOpen = false
        isWarningsOpen = false
        isTreatedDiseasesOpen = false
        
        if isInfoOpen {
            isInfoOpen = false
            infoCellHeight = 60
            infoImage.image = UIImage(named: "downarrowgreen")
            detailsTable.reloadData()
        }else {
            isInfoOpen = true
            infoCellHeight = 80 + infoTV.getHeight()
            infoImage.image = UIImage(named: "uparrowgreen")
            detailsTable.reloadData()
        }
    }
    
    @IBAction func activeSubstancesBtn_tapped(_ sender: Any) {
        cellsBackToDefault()
        
        isInfoOpen = false
        isInstructionsOpen = false
        isSideEffectsOpen = false
        isWarningsOpen = false
        isTreatedDiseasesOpen = false
        
        if isActiveSubstancesOpen {
            isActiveSubstancesOpen = false
            activeSubstancesCellHeight = 60
            activeSubstancesImage.image = UIImage(named: "downarrowgreen")
            detailsTable.reloadData()
        }else {
            isActiveSubstancesOpen = true
            activeSubstancesCellHeight = 80 + activeSubstancesTV.getHeight()
            activeSubstancesImage.image = UIImage(named: "uparrowgreen")
            detailsTable.reloadData()
        }
    }
    
    @IBAction func instructionsBtn_tapped(_ sender: Any) {
        cellsBackToDefault()
        
        isInfoOpen = false
        isActiveSubstancesOpen = false
        isSideEffectsOpen = false
        isWarningsOpen = false
        isTreatedDiseasesOpen = false
        
        if isInstructionsOpen {
            isInstructionsOpen = false
            instructionsCellHeight = 60
            instructionsImage.image = UIImage(named: "downarrowgreen")
            detailsTable.reloadData()
        }else {
            isInstructionsOpen = true
            instructionsCellHeight = 80 + instructionsTV.getHeight()
            instructionsImage.image = UIImage(named: "uparrowgreen")
            detailsTable.reloadData()
        }
    }
    
    @IBAction func sideEffectsBtn_tapped(_ sender: Any) {
        cellsBackToDefault()

        isInfoOpen = false
        isActiveSubstancesOpen = false
        isInstructionsOpen = false
        isWarningsOpen = false
        isTreatedDiseasesOpen = false
        
        if isSideEffectsOpen {
            isSideEffectsOpen = false
            sideEffectsCellHeight = 60
            sideEffectsImage.image = UIImage(named: "downarrowgreen")
            detailsTable.reloadData()
        }else {
            isSideEffectsOpen = true
            sideEffectsCellHeight = 80 + sideEffectsTV.getHeight()
            sideEffectsImage.image = UIImage(named: "uparrowgreen")
            detailsTable.reloadData()
        }
    }
    
    @IBAction func warningsTVBtn_tapped(_ sender: Any) {
        cellsBackToDefault()

        isInfoOpen = false
        isActiveSubstancesOpen = false
        isInstructionsOpen = false
        isSideEffectsOpen = false
        isTreatedDiseasesOpen = false
        
        if isWarningsOpen {
            isWarningsOpen = false
            warningsCellHeight = 60
            warningsImage.image = UIImage(named: "downarrowgreen")
            detailsTable.reloadData()
        }else {
            isWarningsOpen = true
            warningsCellHeight = 80 + warningsTV.getHeight()
            warningsImage.image = UIImage(named: "uparrowgreen")
            detailsTable.reloadData()
        }
        
    }
    
    @IBAction func treatedDiseasesBtn_tapped(_ sender: Any) {
        cellsBackToDefault()

        isInfoOpen = false
        isActiveSubstancesOpen = false
        isInstructionsOpen = false
        isSideEffectsOpen = false
        isWarningsOpen = false
        
        if isTreatedDiseasesOpen {
            isTreatedDiseasesOpen = false
            treatedDiseasesCellHeight = 60
            treatedDiseasesImage.image = UIImage(named: "downarrowgreen")
            detailsTable.reloadData()
        }else {
            isTreatedDiseasesOpen = true
            treatedDiseasesCellHeight = CGFloat(80 + (diseasesList.count * 50))
            treatedDiseasesImage.image = UIImage(named: "uparrowgreen")
            detailsTable.reloadData()
        }
        
    }

}

extension MedicineDetailsVC: DetailsPresenterView {
    func getMedicineDetailsSuccess(_ medicine: DetailsData) {
        medicineImage.sd_setImage(with: URL(string: medicine.image ?? ""))

        medicineName.text = medicine.arabic_name ?? ""
        medicineSection.text = medicine.section_name ?? ""
        
        inMyList = medicine.in_list ?? 0
        
        if inMyList == 0 {
            addToMyListBtn.setTitle("اضف إلى قائمتي", for: .normal)
        }else {
            addToMyListBtn.setTitle("حذف من قائمتي", for: .normal)
        }

        infoTV.text = medicine.about ?? ""
        activeSubstancesTV.text = medicine.active_substances ?? ""
        instructionsTV.text = medicine.instructions ?? ""
        sideEffectsTV.text = medicine.side_effects ?? ""
        warningsTV.text = medicine.warnings ?? ""
        
        diseasesList = medicine.Drug_diseases ?? []
        diseasesCV.reloadData()
    }
    
    func getMedicineDetailsFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func getAddToListSuccess(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertSuccess)
        ShowMedicineDetails()
    }
    
    func getAddToListFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func getRemoveFromListSuccess(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertSuccess)
        ShowMedicineDetails()
    }
    
    func getRemoveFromListFailure(_ message: String) {
        Helper.showFloatAlert(title: message, subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    
}

extension MedicineDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 16), height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diseasesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LettersCell", for: indexPath) as?
            LettersCell else {
                return UICollectionViewCell()
        }
        
        cell.configDiseasesCell(item: diseasesList[indexPath.row])

        return cell
    }
    
    
}
