//
//  MockPlacesService.swift
//  MondriaanPlacesTests
//
//  Created by Benedek Varga on 2020. 04. 01..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift
@testable import MondriaanPlaces

struct MockPlacesService: PlacesServiceProtocol {
    func download() -> Single<[Place]> {
        let places = [
            Place(name: "Future office",
                  city: "Budapest",
                  address: "1036 Budapest, Lajos utca 48-66.",
                  imageUrl: "http://candidate.mondriaan.com/img/Future office.jpg",
                  description: "We're starting to outgrow our current office, this is where our next home is going to be.",
                  latitude: 47.529865,
                  longitude: 19.03889
            ),
            Place(name: "Jopenkerk",
                  city: "Amsterdam",
                  address: "Gedempte Voldersgracht 2, 2011 WD Haarlem",
                  imageUrl: "http://candidate.mondriaan.com/img/Jopenkerk.jpg",
                  description: "Jopen opened a brewery in a former church in central Haarlem called the Jopenkerk.",
                  latitude: 52.381219,
                  longitude: 4.629737
            ),
            Place(name: "Helsinki office",
                  city: "Helsinki",
                  address: "Töölönlahdenkatu 2, 00100 Helsinki",
                  imageUrl: "http://candidate.mondriaan.com/img/Helsinki office.jpg",
                  description: "The Finnish office is located in the heart of Helsinki. The building is called Sanomatalo, it was designed by Jan Söderlund and Antti-Matti Siikala.",
                  latitude: 60.172432,
                  longitude: 24.937898
            )
        ]

        return .just(places)
    }

    
}
