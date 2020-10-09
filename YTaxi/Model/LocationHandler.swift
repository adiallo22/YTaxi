//
//  LocationHandler.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/9/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import CoreLocation

class LocationHandler : NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    
    var locationManager : CLLocationManager!
    var location : CLLocation?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
}

extension LocationHandler {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location has changed..")
    }
    
    func enableLocationService() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("not determined..")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("authorized always in use..   ")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("authorized when in use..")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
}
