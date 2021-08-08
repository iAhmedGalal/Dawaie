//
//  RoundRectView.swift
//  JAK
//
//  Created by Zeinab Reda on 5/23/17.
//  Copyright © 2017 Zeinab Reda. All rights reserved.
//

import UIKit

@IBDesignable class RoundRectView: UIView {
    @IBInspectable var borderColor: UIColor = UIColor.white {
         didSet {
             self.layer.borderColor = borderColor.cgColor
         }
     }

     @IBInspectable var borderWidth: CGFloat = 2.0 {
         didSet {
             self.layer.borderWidth = borderWidth
         }
     }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}
