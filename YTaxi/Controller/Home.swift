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

private let reuseIdentifier = "LocationCell"

class Home : UIViewController {
    
    private var mapView = MKMapView()
    
    private let locationManager = CLLocationManager()
    
    private let login = LoginService()
    
    private let inputActivationView = LocationActivationInputView()
    
    private let locationInputView = LocationInputView()
    
    private let tableView = UITableView()
    
    private var service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputActivationView.delegate = self
        locationInputView.delegate = self
        checkUserLogStatus()
        enableLocationService()
        fetchUserData()
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
        configureTableView()
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
            UIView.animate(withDuration: 0.5) {
                self.tableView.frame.origin.y = self.locationInputView.frame.height
            }
        }
    }
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .customWhiteForDarkMode()
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        //
        view.addSubview(tableView)
        tableView.frame = CGRect.init(x: 0,
                                      y: view.frame.height,
                                      width: view.frame.width,
                                      height: view.frame.height * 0.80)
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
    
    fileprivate func fetchUserData() {
        service.fetchUserData { [weak self] result in
            switch result {
            case .success(let dictionaryData):
                let viewModel = UserDataViewModel(dictionaryData: dictionaryData)
                self?.locationInputView.usernameLabel.text = viewModel.fullname
            case .failure(let error):
                print("ERROR - \(error.description)")
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
        UIView.animate(withDuration: 0.50, animations: {
            self.tableView.frame.origin.y = self.view.frame.height
        }) { _ in
            UIView.animate(withDuration: 0.75, animations: {
                view.removeFromSuperview()
            }) { _ in
                UIView.animate(withDuration: 0.75) {
                    self.inputActivationView.alpha = 1.0
                }
            }
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension Home : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Saved" : "Result"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }
        return cell
    }
}
