//
//  NotificationsCell.swift
//  Dawayiy
//
//  Created by AL Badr  on 2/11/20.
//  Copyright © 2020 ALBadr. All rights reserved.
//

import UIKit

class NotificationsCell: UICollectionViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notficationContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        notificationImage.layer.cornerRadius = 6
    }
    
    func configCell(item: NotificationData) {
        notificationTitle.text = "دوائي"
        notficationContent.text = item.message ?? ""
    }

}
