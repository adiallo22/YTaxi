//
//  UIView.swift
//  HelloTaxi
//
//  Created by Abdul Diallo on 10/2/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    func inputContainerView(withIcon icon : UIImage,
                            and textField : UITextField? = nil,
                            andSegment segmentedController : UISegmentedControl? = nil) -> UIView {
        let view = UIView()
        let iconView = UIImageView.init(image: icon)
        //anchor iconView
        view.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.centerY.equalTo(view)
            make.leading.equalTo(view).inset(8)
        }
        //anchor textField
        if let textField = textField {
            view.addSubview(textField)
            textField.snp.makeConstraints { make in
                make.centerY.equalTo(view)
                make.left.equalTo(iconView.snp.right).inset(-8)
                make.trailing.equalToSuperview().inset(8)
                make.height.equalTo(24)
            }
        }
        //anchor segmented controller
        if let segmentedController = segmentedController {
            view.addSubview(segmentedController)
            segmentedController.snp.makeConstraints { make in
                make.centerY.equalTo(view)
                make.left.equalTo(iconView.snp.right).inset(-8)
                make.trailing.equalToSuperview().inset(8)
                make.height.equalTo(24)
            }
        }
        //anchor seperatorLine
        let seperatorLine = UIView()
        seperatorLine.backgroundColor = .white
        view.addSubview(seperatorLine)
        seperatorLine.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).inset(-4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.75)
        }
        return view
    }
    
}

