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
    
    func customTextfield(backgroundColor : UIColor, placeholder : String, enable : Bool) -> UITextField {
        let tf = UITextField()
        let frontPadding = UIView()
        tf.leftView = frontPadding
        tf.leftViewMode = .always
        frontPadding.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        tf.placeholder = placeholder
        tf.backgroundColor = backgroundColor
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isEnabled = enable
        return tf
    }
    
}

