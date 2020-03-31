//
//  PlaceDetailsInputModelProtocol.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import MapKit

struct PinModel {
    let name: String
    let city: String
    let coordinates: CLLocationCoordinate2D
}

protocol PlaceDetailsInputModelProtocol: RootInputModelProtocol {
    var title: String { get }
    var pins: [PinModel] { get }
}
