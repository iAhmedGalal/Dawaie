//
//  MedicinesVC.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/11/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class MedicinesVC: UIViewController {
    
    @IBOutlet weak var lettersCV: UICollectionView!
    @IBOutlet weak var itemsCV: UICollectionView!
    
    fileprivate var presenter: MedicinesPresenter?
    
    var lettersList: [String] = []
    var medicinesList: [MedicinesData] = []
    
    var selectedLetter: String = ""
    var selectedIndex: Int = 0
    
    var seletedSectionId: String = ""
    var selectedDiseaseId: String = ""
    var selectedFormId: String = ""
    var selectedColorId: String = ""
    var seletedDivideId: String = ""

    var searchPage: Int = 1
    var searchLastPage: Int = 1
    
    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        initViews()
        
        lettersList.append("أ")
        lettersList.append("ب")
        lettersList.append("ت")
        lettersList.append("ث")
        lettersList.append("ج")
        lettersList.append("ح")
        lettersList.append("خ")
        lettersList.append("د")
        lettersList.append("ذ")
        lettersList.append("ر")
        lettersList.append("ز")
        lettersList.append("س")
        lettersList.append("ش")
        lettersList.append("ص")
        lettersList.append("ض")
        lettersList.append("ط")
        lettersList.append("ظ")
        lettersList.append("ع")
        lettersList.append("غ")
        lettersList.append("ف")
        lettersList.append("ق")
        lettersList.append("ك")
        lettersList.append("ل")
        lettersList.append("م")
        lettersList.append("ن")
        lettersList.append("هـ")
        lettersList.append("و")
        lettersList.append("ي")
        
        lettersCV.reloadData()
        
        presenter = MedicinesPresenter(self)

        showMedicines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func initViews() {
        lettersCV.register(UINib.init(nibName: "LettersCell", bundle: nil), forCellWithReuseIdentifier: "LettersCell")
        itemsCV.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")

        lettersCV.dataSource = self
        lettersCV.delegate = self
        
        itemsCV.dataSource = self
        itemsCV.delegate = self
    }
    
    func showMedicines() {
        let parameters = ["search_text": searchText,
                          "section_id": seletedSectionId,
                          "disease_id": selectedDiseaseId,
                          "medication_form_id": selectedFormId,
                          "color_id": selectedColorId,
                          "pill_divide_id": seletedDivideId,
                          "order_character": selectedLetter,
                          "page": searchPage] as [String : Any]
        presenter?.getMedicines(parameters: parameters)
    }
 
}

extension MedicinesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lettersCV {
            return CGSize(width: 40, height: 40)
        }else {
            return CGSize(width: (UIScreen.main.bounds.width - 16) * 0.3, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == lettersCV {
            return lettersList.count
        }else {
            return medicinesList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == lettersCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LettersCell", for: indexPath) as?
                LettersCell else {
                    return UICollectionViewCell()
            }
            
            cell.configCell(item: lettersList[indexPath.row])

            return cell
            
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as?
                SearchCell else {
                    return UICollectionViewCell()
            }
            
            cell.configCell(item: medicinesList[indexPath.row])
            
            if indexPath.row + 1 == medicinesList.count{
                if searchPage < searchLastPage {
                    searchPage = searchPage + 1
                    showMedicines()
                }
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == lettersCV {
            if let cell = lettersCV.cellForItem(at: indexPath) as? LettersCell {
                cell.cellView.backgroundColor = UIColor(red:0.73, green:0.83, blue:0.87, alpha:1.0)
                selectedLetter = cell.letter.text ?? ""
                searchPage = 1
                showMedicines()
            }
        }else {
            let sb = UIStoryboard(name: Constants.storyBoard.main, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MedicineDetailsVC") as! MedicineDetailsVC
            vc.title = medicinesList[indexPath.row].arabic_name ?? ""
            vc.medicineId = medicinesList[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == lettersCV {
            if let cell = lettersCV.cellForItem(at: indexPath) as? LettersCell {
                cell.cellView.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
            }
        }
    }
}

extension MedicinesVC: MedicinesPresenterView {
    func setMedicines(_ medicines: [MedicinesData]) {
        var meds : [MedicinesData] = []
        meds = medicines
        
        if searchPage == 1{
            medicinesList.removeAll()
            medicinesList = meds
            itemsCV.reloadData()
        }else {
            medicinesList.append(contentsOf: meds)
            itemsCV.reloadData()
        }
    }
    
    func setLastPage(_ lastPage: Int) {
        searchLastPage = lastPage
    }
    
    func setMedicinesFailure() {}
    
    func showConnectionErrorMessage() {
        Helper.showFloatAlert(title: "من فضلك تأكد من اتصالك بالإنترنت", subTitle: "", type: Constants.AlertType.AlertError)
    }
    
    
}

