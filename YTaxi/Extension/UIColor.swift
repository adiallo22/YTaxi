//
//  UIColor.swift
//  HelloTaxi
//
//  Created by Abdul Diallo on 10/2/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    static func backgroundColor() -> UIColor {
        return rgb(red: 25, green: 25, blue: 25)
    }
    static func customBlue() -> UIColor {
        return rgb(red: 17, green: 154, blue: 237)
    }
    static func customWhiteForDarkMode() -> UIColor {
        return UIColor.init(white: 1, alpha: 0.87)
    }
}
