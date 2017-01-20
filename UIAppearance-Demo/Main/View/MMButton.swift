//
//  MMButton.swift
//  UIAppearance-Demo
//
//  Created by 买明 on 20/01/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class MMButton: UIButton {
    
    dynamic var btnBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
}
