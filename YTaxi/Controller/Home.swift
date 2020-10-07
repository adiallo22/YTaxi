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
    
    private let inputActivationView = LocationActivationInputView()
    
    private let locationInputView = LocationInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputActivationView.delegate = self
        locationInputView.delegate = self
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
        inputActivationView.alpha = 0
        UIView.animate(withDuration: 1.5) {
            self.inputActivationView.alpha = 1
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
    
    fileprivate func presentLocationInputView() {
        view.addSubview(locationInputView)
        locationInputView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1.0
        }) { _ in
            //present tableview here..
        }
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

//MARK: - LocationActivationInputViewDelegate

extension Home : LocationActivationInputViewDelegate {
    
    func presentInputView() {
        inputActivationView.alpha = 0
        presentLocationInputView()
    }
    
}

//MARK: - LocationInputViewDelegate

extension Home : LocationInputViewDelegate {
    
    func handleDismiss(_ view: LocationInputView) {
        UIView.animate(withDuration: 0.75) {
            view.removeFromSuperview()
            self.inputActivationView.alpha = 1.0
        }
    }
    
}
