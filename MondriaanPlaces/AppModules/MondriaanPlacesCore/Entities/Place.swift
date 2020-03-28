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
}

extension Place {
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var image: UIImage {
        if let unwrappedImage = _image {
            return unwrappedImage
        }

        guard
            let url = URL(string: imageUrl),
            let data = try? Data(contentsOf: url),
            let downloadedImage = UIImage(data: data)
        else {
            return #imageLiteral(resourceName: "photoPlacehoder")
        }

        return downloadedImage
    }
}
