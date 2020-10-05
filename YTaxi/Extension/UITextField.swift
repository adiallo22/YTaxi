//
//  UITextField.swift
//  HelloTaxi
//
//  Created by Abdul Diallo on 10/2/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

extension UITextField {
    func textField(withPlaceholder placeholder : String, isSecuredEntry : Bool) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .customWhiteForDarkMode()
        textField.keyboardAppearance = .dark
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor : UIColor.lightGray
        ])
        textField.isSecureTextEntry = isSecuredEntry
        return textField
    }
}

