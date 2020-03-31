//
//  PlaceDetailsInputModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

struct PlaceDetailsInputModel: PlaceDetailsInputModelProtocol {
    var title: String
    var pins: [PinModel]
}
