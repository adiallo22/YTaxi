//
//  LocationInputView.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/7/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit

protocol LocationInputViewDelegate : class {
    func handleDismiss(_ view : LocationInputView)
}

class LocationInputView : UIView {
    
    weak var delegate : LocationInputViewDelegate?
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - helpers

extension LocationInputView {
    
    fileprivate func configureUI() {
        backgroundColor = .white
        addShadow()
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(40)
        }
    }
    
}

//MARK: - selectors

extension LocationInputView {
    @objc func handleDismissal() {
        delegate?.handleDismiss(self)
    }
}
