//
//  DiseasesCell.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/10/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class DiseasesCell: UICollectionViewCell {
    @IBOutlet weak var title: RoundedButton!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(item: DiseasesData) {
        title.setTitle(item.disease_name ?? "", for: .normal)
    }
    
    func configSectionsCell(item: SectionsData) {
        title.setTitle(item.section_name ?? "", for: .normal)
    }

}
