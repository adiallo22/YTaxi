//
//  Home.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class Home : UIViewController {
    
    private var mapView = MKMapView()
    
    private let log = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserLogStatus()
    }
    
}

//MARK: - configurations and helpers

extension Home {
    
    fileprivate func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
    
    fileprivate func presentLoginScreen() {
        navigationController?.pushViewController(Login(), animated: true)
    }
    
    fileprivate func checkUserLogStatus() {
        guard Auth.auth().currentUser?.uid != nil else {
            presentLoginScreen()
            return
        }
        configureUI()
    }
    
}

//MARK: - API

extension Home {
    fileprivate func signout() {
        log.logout { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
