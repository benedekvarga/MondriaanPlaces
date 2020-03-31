//
//  Providing.swift
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Foundation
import Moya

// MARK: - Types

// Definitely would not store username and password here in production
private struct UserStore {
    private static let username = "candidate"
    private static let password = "Ahs6aiX7"

    static let token = Data("\(UserStore.username):\(UserStore.password)".utf8).base64EncodedString()
}

protocol Providing {}

extension Providing where Self: TargetType {
    static var provider: MoyaProvider<Self> {
        var plugins = [PluginType]()
        let authPlugin = AccessTokenPlugin { _ in UserStore.token }
        plugins.append(authPlugin)
        let networkActivityClosure: NetworkActivityPlugin.NetworkActivityClosure = { change, _ in
            DispatchQueue.main.async {
                switch change {
                case .began:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                case .ended:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }

        let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: networkActivityClosure)
        plugins.append(networkActivityPlugin)

        let networkLoggerPlugin = NetworkLoggerPlugin()
        plugins.append(networkLoggerPlugin)

        return MoyaProvider<Self>(callbackQueue: DispatchQueue.global(qos: .utility), plugins: plugins)
    }
}
