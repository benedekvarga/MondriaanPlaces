//
//  SectionHeaderInputModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

struct SectionHeaderInputModel: SectionHeaderInputModelProtocol {
    // MARK: - Properties

    let title: String
    var itemSelected: (() -> PlaceDetailsInputModelProtocol)
}
