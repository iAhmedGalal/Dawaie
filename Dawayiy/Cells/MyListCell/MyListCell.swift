//
//  MyListCell.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/10/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import SDWebImage

class MyListCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var deleteBtn: RoundedButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image.layer.cornerRadius = 15
    }
    
    func configCell(item: MedicinesData){
        name.text = item.Drug_arabic_name ?? ""
        image.sd_setImage(with: URL(string: item.Drug_image ?? ""))
    }
}
