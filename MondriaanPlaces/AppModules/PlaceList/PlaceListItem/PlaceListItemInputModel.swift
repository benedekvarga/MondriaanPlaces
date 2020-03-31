//
//  PlaceListItemInputModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

struct PlaceListItemInputModel: PlaceListItemInputModelProtocol {
    let title: String
    let subtitle: String
    let description: String
    let imageUrl: String
    let itemSelected: (() -> PlaceDetailsInputModelProtocol)
}
