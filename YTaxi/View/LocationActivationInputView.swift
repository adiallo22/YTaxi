//
//  LocationActivationInputView.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

class LocationActivationInputView : UIView {
    
    private let blackIndicatorSquare : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeholderLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "WAhere to?"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configuration() {
        addSubview(blackIndicatorSquare)
        blackIndicatorSquare.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(6)
        }
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalTo(blackIndicatorSquare.snp.right).inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
}
