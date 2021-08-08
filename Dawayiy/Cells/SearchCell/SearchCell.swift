//
//  SearchCell.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/10/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        image.layer.cornerRadius = 10
    }
    
    func configCell(item: MedicinesData) {
        name.text = item.arabic_name ?? ""
        image.sd_setImage(with: URL(string: item.image ?? ""))
    }

}
