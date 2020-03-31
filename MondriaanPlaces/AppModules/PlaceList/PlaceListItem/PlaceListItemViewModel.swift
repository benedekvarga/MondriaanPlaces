//
//  PlaceListItemViewModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

class PlaceListItemViewModel: RootViewModel, PlaceListItemViewModelProtocol {
    // MARK: - Properties

    let title: String
    let subtitle: String
    var description: String
    var image: UIImage
    var itemSelected: (() -> Void)

    init(inputView: PlaceListItemInputModelProtocol) {
        self.title = inputView.title
        self.subtitle = inputView.subtitle
        self.description = inputView.description
        self.image = inputView.image
        self.itemSelected = inputView.itemSelected

        super.init(inputView: inputView)
    }
}

extension PlaceListItemViewModel: Equatable {
    static func == (lhs: PlaceListItemViewModel, rhs: PlaceListItemViewModel) -> Bool {
        return
            lhs.title == rhs.title &&
            lhs.subtitle == rhs.subtitle &&
            lhs.description == rhs.description &&
            lhs.image == rhs.image
    }
}

extension PlaceListItemViewModel: IdentifiableType {
    typealias Identity = String

    var identity: String {
        return "\(title)-\(subtitle)-\(image.description)"
    }
}
