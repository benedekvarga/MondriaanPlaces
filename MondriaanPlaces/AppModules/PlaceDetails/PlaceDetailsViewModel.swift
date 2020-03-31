//
//  PlaceDetailsViewModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift

class PlaceDetailsViewModel: RootViewModel, PlaceDetailsViewModelProtocol {
    // MARK: - PlaceDetailsViewModelProtocol properties

    let title: String
    let pins: [PinModel]

    // MARK: - Initialization

    init(inputView: PlaceDetailsInputModelProtocol) {
        self.title = inputView.title
        self.pins = inputView.pins

        super.init()
    }
}
