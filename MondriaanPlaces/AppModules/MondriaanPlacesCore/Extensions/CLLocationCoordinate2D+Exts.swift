//
//  CLLocationCoordinate2D+Exts.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import MapKit

extension Array where Element == CLLocationCoordinate2D {
    func center() -> CLLocationCoordinate2D {
        var maxLatitude: Double = -200
        var maxLongitude: Double = -200
        var minLatitude: Double = Double(MAXFLOAT)
        var minLongitude: Double = Double(MAXFLOAT)

        for location in self {
            if location.latitude < minLatitude {
                minLatitude = location.latitude
            }

            if location.longitude < minLongitude {
                minLongitude = location.longitude
            }

            if location.latitude > maxLatitude {
                maxLatitude = location.latitude
            }

            if location.longitude > maxLongitude {
                maxLongitude = location.longitude
            }
        }

        return CLLocationCoordinate2DMake(CLLocationDegrees((maxLatitude + minLatitude) * 0.5), CLLocationDegrees((maxLongitude + minLongitude) * 0.5))
    }
}
