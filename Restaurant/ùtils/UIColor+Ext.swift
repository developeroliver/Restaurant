//
//  UIColor+Ext.swift
//  Restaurant
//
//  Created by olivier geiger on 28/03/2024.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha
                  : 1.0)
    }
}
