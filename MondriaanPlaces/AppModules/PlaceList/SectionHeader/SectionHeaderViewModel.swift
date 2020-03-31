//
//  SectionHeaderViewModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

class SectionHeaderViewModel: RootViewModel, SectionHeaderViewModelProtocol {
    // MARK: - Properties

    let title: String
    let onTap: (() -> Void)

    init(inputView: SectionHeaderInputModelProtocol) {
        self.title = inputView.title
        self.onTap = inputView.onTap

        super.init()
    }
}
