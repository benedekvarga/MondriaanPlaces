//
//  MondriaanPlacesTests.swift
//  MondriaanPlacesTests
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import XCTest
import Swinject

@testable import MondriaanPlaces

class MondriaanPlacesTests: XCTestCase {

    private let container = Container()

    override func setUp() {
        super.setUp()

        container.register(PlacesServiceProtocol.self) { _ in
            return MockPlacesService()
        }

        container.register(PlaceListViewModelProtocol.self) { _ in
            let service = self.container.resolve(PlacesServiceProtocol.self)!

            return PlaceListViewModel(placesService: service)
        }
    }

    override func tearDown() {
        super.tearDown()

        container.removeAll()
    }

    func testViewModel() {
        let viewModel = container.resolve(PlaceListViewModelProtocol.self)!
        viewModel.onReload()

        XCTAssertEqual(viewModel.sectionHeaders.map { $0.title }, ["Amsterdam", "Budapest", "Helsinki"])
    }
}
