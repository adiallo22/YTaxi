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
    
    //MARK: - properties
    
    weak var delegate : LocationInputViewDelegate?
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "Abdul Diallo"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private var startBackSquare : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private var destinationBackSquare : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private var linkingLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var currentLocationTextField : UITextField = {
        let tf = UITextField().customTextfield(backgroundColor: .systemGroupedBackground,
                                               placeholder: "Current Location",
                                               enable: false)
        return tf
    }()
    
    private let destinationTextField : UITextField = {
        let tf = UITextField().customTextfield(backgroundColor: .lightGray,
                                               placeholder: "Enter Location",
                                               enable: true)
        return tf
    }()
    
    private let backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    //MARK: - initialisers
    
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
        //
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
        }
        //
        addSubview(currentLocationTextField)
        currentLocationTextField.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).inset(-8)
            make.leading.equalTo(backButton.snp.trailing).inset(-8)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        //
        addSubview(destinationTextField)
        destinationTextField.snp.makeConstraints { make in
            make.top.equalTo(currentLocationTextField.snp.bottom).inset(-10)
            make.leading.equalTo(backButton.snp.trailing).inset(-8)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        //
        addSubview(startBackSquare)
        startBackSquare.snp.makeConstraints { make in
            make.centerY.equalTo(currentLocationTextField)
            make.centerX.equalTo(backButton)
            make.height.width.equalTo(6)
        }
        startBackSquare.clipsToBounds = true
        startBackSquare.layer.cornerRadius = 3
        //
        addSubview(destinationBackSquare)
        destinationBackSquare.snp.makeConstraints { make in
            make.centerY.equalTo(destinationTextField)
            make.centerX.equalTo(backButton)
            make.height.width.equalTo(10)
        }
        //
        addSubview(linkingLineView)
        linkingLineView.snp.makeConstraints { make in
            make.width.equalTo(0.75)
            make.top.equalTo(startBackSquare.snp.bottom).inset(-4)
            make.bottom.equalTo(destinationBackSquare.snp.top).inset(-4)
            make.centerX.equalTo(startBackSquare)
        }
    }
    
}

//MARK: - selectors

extension LocationInputView {
    @objc func handleDismissal() {
        delegate?.handleDismiss(self)
    }
}
