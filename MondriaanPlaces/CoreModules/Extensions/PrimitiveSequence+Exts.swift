//
//  PrimitiveSequence+Exts.swift
//
//  Created by Benedek Varga on 2020. 03. 26..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapSwiftyJSON() -> Single<JSON> {
        return flatMap { response -> Single<JSON> in
            Single.just(try JSON(data: response.data))
        }
    }
}
