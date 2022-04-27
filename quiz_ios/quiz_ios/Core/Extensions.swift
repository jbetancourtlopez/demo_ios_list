//
//  Extensions.swift
//  quiz_ios
//
//  Created by Jossue Betancourt on 14/03/22.
//

import Foundation
import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
