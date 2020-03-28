//
//  Reachability+Exts.swift
//
//  Created by Benedek Varga on 2020. 03. 26..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Reachability
import RxSwift

extension Reactive where Base: Reachability {
    static var isReachable: Observable<Bool> {
        return Observable.create { observer in
            let reachability = Reachability.forInternetConnection()
            if let reachability = reachability {
                observer.onNext(reachability.isReachable())
                reachability.reachableBlock = { _ in observer.onNext(true) }
                reachability.unreachableBlock = { _ in observer.onNext(false) }
                reachability.startNotifier()
            } else {
                observer.onError(NetworkError.noInternetConnection)
            }
            return Disposables.create {
                reachability?.stopNotifier()
            }
        }
    }
}
