//
//  SignUpService.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/12/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Firebase
import GeoFire

protocol SignupDelegate {
    func signup(withCredentials credentials : UserCredential, and password: String, completion : @escaping(Error?)->Void)
}

struct SignupService : SignupDelegate {
    
    func signup(withCredentials credentials : UserCredential, and password: String, completion : @escaping(Error?)->Void) {
        SignupService.createUser(with: credentials.email, and: password) { error, uid  in
            if let error = error {
                completion(error)
            } else {
                guard let uid = uid else { return }
                let value = [
                    UserCredentialEnum.email.rawValue : credentials.email,
                    UserCredentialEnum.fullname.rawValue : credentials.fullname,
                    UserCredentialEnum.userType.rawValue : credentials.userType
                ] as [String:Any]
                self.uploadLocation(withUid: uid, userType: credentials.userType) { error in
                    if let error = error {
                        completion(error)
                    }
                }
                userReference.child(uid).updateChildValues(value) { error, reference in
                    if let error = error {
                        completion(error)
                    }
                }
            }
        }
    }
    
    static func createUser(with email : String, and password : String, completion : @escaping(Error?, String?)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error, nil)
            }
            guard let uid = result?.user.uid else { return }
            completion(nil, uid)
        }
    }
    
}

extension SignupService {
    fileprivate func uploadLocation(withUid uid : String, userType : Int, completion : @escaping(Error?)->Void) {
        if userType == 1 {
            let geoFire = GeoFire.init(firebaseRef: driverReference)
            guard let location = LocationHandler.shared.locationManager.location else { return }
            geoFire.setLocation(location, forKey: uid) { error in
                if let error = error {
                    completion(error)
                }
            }
        }
    }
}
