//
//  RxProvider.swift
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Reachability

final class RxProvider<T: TargetType & Providing> {
    private let provider: MoyaProvider<T>
    private let online: Observable<Bool>

    init(provider: MoyaProvider<T> = T.provider, online: Observable<Bool> = Reachability.rx.isReachable ) {
        self.provider = provider
        self.online = online
    }

    func request(_ token: T) -> Single<Moya.Response> {
        let request = provider.rx.request(token, callbackQueue: DispatchQueue.global(qos: .utility))
        return online
            .take(1)
            .asSingle()
            .do(onSuccess: {
                if !$0 {
                    throw NetworkError.noInternetConnection
                }
            })
            .flatMap { _ in
                return request.retry(1)
            }
            .do(onSuccess: { response in
                if response.statusCode == 500 {
                    throw NetworkError.backendError("Server unavailable.")
                }
            })
    }
}

