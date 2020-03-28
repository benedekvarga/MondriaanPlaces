//
//  NetworkError.swift
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

enum NetworkError: Error {
    case noInternetConnection
    case backendError(String)
    case invalidJSON(String)
    case generalError
}
