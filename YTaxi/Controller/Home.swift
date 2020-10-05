//
//  Home.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/5/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import Firebase

class Home : UIViewController {
    
    private let log = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor()
        signout()
        checkUserLogStatus()
    }
    
}

//MARK: - configurations and helpers

extension Home {
    
    fileprivate func presentLoginScreen() {
        navigationController?.pushViewController(Login(), animated: true)
    }
    
    fileprivate func checkUserLogStatus() {
        guard Auth.auth().currentUser?.uid != nil else {
            presentLoginScreen()
            return
        }
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
