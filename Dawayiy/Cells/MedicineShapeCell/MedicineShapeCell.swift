//
//  MedicineShapeCell.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/10/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit
import SDWebImage

class MedicineShapeCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewImage.layer.borderWidth = 1
        viewImage.layer.borderColor = UIColor.lightGray.cgColor
        viewImage.layer.cornerRadius = viewImage.frame.height / 2
        
        cellView.backgroundColor = UIColor.white

    }
    
    func configFormsCell(item: FormsData) {
        name.text = item.form_name ?? ""
        image.sd_setImage(with: URL(string: item.image_url ?? ""))
    }
    
    func configColorsCell(item: ColorsData) {
        name.text = item.color_name ?? ""
        image.image = nil
        viewImage.backgroundColor = Helper.hexStringToUIColor(hex: item.color_code ?? "#FFFFFF")
    }
    
    func configDividesCell(item: DividesData) {
        name.text = item.divide_name ?? ""
        image.sd_setImage(with: URL(string: item.image_url ?? ""))
    }

}
