//
//  LettersCell.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/11/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class LettersCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var letter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(item: String){
        letter.text = item
    }
    
    func configDiseasesCell(item: Drug_diseases){
        cellView.backgroundColor = UIColor.white
        letter.text = item.disease_name ?? ""
        letter.textAlignment = .right
    }

}
