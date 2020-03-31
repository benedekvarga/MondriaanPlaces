//
//  PlaceListViewModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift

class PlaceListViewModel: RootViewModel, PlaceListViewModelProtocol {
    // MARK: - PlaceListViewModelProtocol properties

    var places = BehaviorSubject<[[PlaceListItemViewModelProtocol]]>(value: [])
    var sectionHeaders = [SectionHeaderViewModelProtocol]()

    // MARK: - Properties

    // MARK: - PlaceListViewModelProtocol functions

    override func initializeViewModel() {
        super.initializeViewModel()

        populateDummyData()
    }
}

// MARK: - Dummy data

extension PlaceListViewModel {
    private func populateDummyData() {
        let dummyInputModel = PlaceListItemInputModel(
            title: "Budapest",
            subtitle: "Petőfi utca 11.",
            description: "A Lorem Ipsum egy egyszerû szövegrészlete, szövegutánzata a betûszedõ és nyomdaiparnak. A Lorem Ipsum az 1500-as évek.",
            image: #imageLiteral(resourceName: "photoPlacehoder"),
            itemSelected: { debugLog("Budapest") }
        )

        let dummyPlaces: [PlaceListItemViewModelProtocol] = [
            PlaceListItemViewModel(inputView: dummyInputModel),
            PlaceListItemViewModel(inputView: dummyInputModel),
            PlaceListItemViewModel(inputView: dummyInputModel),
            PlaceListItemViewModel(inputView: dummyInputModel),
            PlaceListItemViewModel(inputView: dummyInputModel),
            PlaceListItemViewModel(inputView: dummyInputModel),
            PlaceListItemViewModel(inputView: dummyInputModel),
            PlaceListItemViewModel(inputView: dummyInputModel)
        ]

        let dummyHeaders = [
            SectionHeaderViewModel(inputView: SectionHeaderInputModel(title: "Budapest", onTap: { debugLog("Budapest header tap") })),
            SectionHeaderViewModel(inputView: SectionHeaderInputModel(title: "Stockholm", onTap: { debugLog("Stockhol header tap") }))
        ]

        places.onNext([dummyPlaces, dummyPlaces])
        sectionHeaders = dummyHeaders
    }
}
