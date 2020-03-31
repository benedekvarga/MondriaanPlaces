//
//  Place.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import CoreLocation
import UIKit

struct Place {
    let name: String
    let city: String
    let address: String
    let imageUrl: String
    let description: String
    let latitude: Double
    let longitude: Double

    private var _image: UIImage?

    init(name: String, city: String, address: String, imageUrl: String, description: String, latitude: Double, longitude: Double) {
        self.name = name
        self.city = city
        self.address = address
        self.imageUrl = imageUrl
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self._image = nil
    }
}

extension Place {
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
