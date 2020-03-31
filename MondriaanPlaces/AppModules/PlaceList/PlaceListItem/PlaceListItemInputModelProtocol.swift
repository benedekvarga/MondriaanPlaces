//
//  PlaceListItemInputModelProtocol.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

protocol PlaceListItemInputModelProtocol: RootInputModelProtocol {
    var title: String { get }
    var subtitle: String { get }
    var description: String { get }
    var imageUrl: String { get }
    var itemSelected: (() -> PlaceDetailsInputModelProtocol) { get }
}
