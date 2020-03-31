//
//  NetworkError.swift
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case backendError(String)
    case invalidJSON(String)
    case generalError
}
