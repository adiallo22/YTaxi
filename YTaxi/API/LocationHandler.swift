//
//  LocationHandler.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import CoreLocation

class LocationHandler : NSObject, CLLocationManagerDelegate {
    
    let shared = LocationHandler()
    var locationManager : CLLocationManager!
    var location : CLLocation?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
    }
    
}
