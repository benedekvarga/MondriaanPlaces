//
//  PlacesService.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol PlacesServiceProtocol {
    func download() -> Single<[Place]>
}

struct PlacesService: PlacesServiceProtocol {
    private let provider: RxProvider<MdcAPI>

    init(provider: RxProvider<MdcAPI>) {
        self.provider = provider
    }

    func download() -> Single<[Place]> {
        return provider
            .request(.places)
            .map { $0.data }
            .map { data in
                do {
                    let jsonDecoder = JSONDecoder()
                    let places = try jsonDecoder.decode([Place].self, from: data)
                    return places
                } catch {
                    errorLog("Cannot parse data.")
                    return []
                }
            }
    }
}
