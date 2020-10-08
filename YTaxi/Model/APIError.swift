//
//  APIError.swift
//  YTaxi
//
//  Created by Abdul Diallo on 10/8/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import Foundation

enum APIError : Error {
    case downcasting(val: String)
    var description : String {
        switch self {
        case .downcasting(let value):
            return "Error downcasting \(value)"
        }
    }
}
