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
import SnapKit

class Home : UIViewController {
    
    private var mapView = MKMapView()
    
    private let locationManager = CLLocationManager()
    
    private let login = LoginService()
    
    private var inputActivationView = LocationActivationInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        signout()
        checkUserLogStatus()
        enableLocationService()
    }
    
}

//MARK: - configurations and helpers

extension Home {
    
    fileprivate func configureUI() {
        navigationController?.navigationBar.isHidden = true
        configureMapView()
        view.addSubview(inputActivationView)
        inputActivationView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    fileprivate func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    fileprivate func presentLoginScreen() {
        navigationController?.pushViewController(Login(), animated: true)
    }
    
    func checkUserLogStatus() {
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
        login.logout { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Location services

extension Home : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    fileprivate func enableLocationService() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            CLLocationManager().requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
}
