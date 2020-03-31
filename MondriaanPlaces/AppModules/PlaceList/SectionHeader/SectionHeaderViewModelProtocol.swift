//
//  SectionHeaderViewModelProtocol.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

protocol SectionHeaderViewModelProtocol {
    var title: String { get }
    var itemSelected: (() -> PlaceDetailsInputModelProtocol) { get }
}
