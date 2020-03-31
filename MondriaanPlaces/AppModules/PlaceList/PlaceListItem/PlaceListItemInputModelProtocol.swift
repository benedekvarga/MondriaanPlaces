//
//  PlaceListItemInputModelProtocol.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit

protocol PlaceListItemInputModelProtocol: RootInputModelProtocol {
    var title: String { get }
    var subtitle: String { get }
    var description: String { get }
    var image: UIImage { get }
    var itemSelected: (() -> Void) { get }
}