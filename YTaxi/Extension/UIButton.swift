//
//  UIButton.swift
//  HelloTaxi
//
//  Created by Abdul Diallo on 10/2/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

extension UIButton {
    
    func segueButton(withTitle title : String, of type : String) -> UIButton {
        let button = UIButton(type: .system)
        let attributed = NSMutableAttributedString.init(string: title, attributes: [
            .font : UIFont.systemFont(ofSize: 16),
            .foregroundColor : UIColor.lightGray
        ])
        attributed.append(NSAttributedString.init(string: type, attributes: [
            .font : UIFont.systemFont(ofSize: 16),
            .foregroundColor : UIColor.customBlue()
        ]))
        button.setAttributedTitle(attributed, for: .normal)
        return button
    }
    
    func authenticationButton(withTitle title : String) -> UIButton {
        let button = UIButton.init(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customBlue()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }
    
}
