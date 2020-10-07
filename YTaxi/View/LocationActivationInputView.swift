//
//  LocationActivationInputView.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol LocationActivationInputViewDelegate : class {
    func presentInputView()
}

class LocationActivationInputView : UIView {
    
    weak var delegate : LocationActivationInputViewDelegate?
    
    private let blackIndicatorSquare : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeholderLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "Where to?"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
        //
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(blackIndicatorSquare.snp.right).inset(-20)
            make.centerY.equalToSuperview()
        }
        //
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleShowInputView))
        addGestureRecognizer(tap)
        //
        addShadow()
    }
    
    fileprivate func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        layer.shadowOpacity = 0.45
    }
    
}

//MARK: - selectors

extension LocationActivationInputView {
    @objc func handleShowInputView() {
        delegate?.presentInputView()
    }
}
