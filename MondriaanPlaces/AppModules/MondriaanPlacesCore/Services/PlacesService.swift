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
import SwiftyJSON

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
            .mapSwiftyJSON()
            .map { json in
                var places: [Place] = []

                json.arrayValue.forEach { item in
                    guard
                        let name = item[ServerKey.name].string,
                        let city = item[ServerKey.city].string,
                        let address = item[ServerKey.address].string,
                        let imageUrl = item[ServerKey.imageUrl].string,
                        let description = item[ServerKey.description].string,
                        let latitude = item[ServerKey.coordinates][ServerKey.latitude].double,
                        let longitude = item[ServerKey.coordinates][ServerKey.longitude].double
                    else {
                        errorLog("Cannot get place.")
                        return
                    }

                    let place = Place(
                        name: name,
                        city: city,
                        address: address,
                        imageUrl: imageUrl,
                        description: description,
                        latitude: latitude,
                        longitude: longitude
                    )
                    places.append(place)
                }
                return places
            }
    }
}
