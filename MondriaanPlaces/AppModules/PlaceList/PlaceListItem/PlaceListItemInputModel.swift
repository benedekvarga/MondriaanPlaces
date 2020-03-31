//
//  PlaceListItemInputModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit

struct PlaceListItemInputModel: PlaceListItemInputModelProtocol {
    let title: String
    let subtitle: String
    let description: String
    let image: UIImage
    let itemSelected: (() -> Void)
}
