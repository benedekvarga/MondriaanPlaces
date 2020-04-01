//
//  Place.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import CoreLocation
import UIKit

struct Place: Decodable {
    let name: String
    let city: String
    let address: String
    let imageUrl: String
    let description: String
    let latitude: Double
    let longitude: Double

    init(name: String, city: String, address: String, imageUrl: String, description: String, latitude: Double, longitude: Double) {
        self.name = name
        self.city = city
        self.address = address
        self.imageUrl = imageUrl
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.city = try container.decode(String.self, forKey: .city)
        self.address = try container.decode(String.self, forKey: .address)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.description = try container.decode(String.self, forKey: .description)

        let coordinatesContainer = try container.nestedContainer(keyedBy: CoordinatesKeys.self, forKey: .coordinates)
        self.latitude = try coordinatesContainer.decode(Double.self, forKey: .latitude)
        self.longitude = try coordinatesContainer.decode(Double.self, forKey: .longitude)
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case city
        case address
        case imageUrl = "image"
        case description
        case coordinates
    }

    private enum CoordinatesKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

extension Place {
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
