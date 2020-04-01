//
//  MondriaanPlacesTests.swift
//  MondriaanPlacesTests
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import XCTest

import MapKit
import Swinject

@testable import MondriaanPlaces

class MondriaanPlacesTests: XCTestCase {

    private let container = Container()

    override func setUp() {
        super.setUp()

        // Services

        container.register(PlacesServiceProtocol.self) { _ in
            return MockPlacesService()
        }

        // ViewModels

        container.register(PlaceListViewModelProtocol.self) { _ in
            let service = self.container.resolve(PlacesServiceProtocol.self)!

            return PlaceListViewModel(placesService: service)
        }

        container.register(PlaceDetailsViewModelProtocol.self) { _ in
            let inputModel = PlaceDetailsInputModel(
                title: "Budapest",
                pins: [
                    PinModel(name: "Future office", city: "Budapest", coordinates: CLLocationCoordinate2D(latitude: 47.529865, longitude: 19.03889)),
                    PinModel(name: "Arnold Gym", city: "Budapest", coordinates: CLLocationCoordinate2D(latitude: 47.527914, longitude: 19.036315)),
                ]
            )
            return PlaceDetailsViewModel(inputView: inputModel)
        }
    }

    override func tearDown() {
        super.tearDown()

        container.removeAll()
    }

    func testPlaceListViewModelSectionHeader() {
        let viewModel = container.resolve(PlaceListViewModelProtocol.self)!
        viewModel.onReload()

        XCTAssertEqual(viewModel.sectionHeaders.map { $0.title }, ["Amsterdam", "Budapest", "Helsinki"])
    }

    func testPlaceDetailsViewModelCenterCalculation() {
        let viewModel = container.resolve(PlaceDetailsViewModelProtocol.self)!
        let center = viewModel.pins.map { $0.coordinates }.center()

        let isEqual = center.latitude == 47.528889500000005 && center.longitude == 19.0376025

        XCTAssertEqual(isEqual, true)
    }

    func testPlaceDetailsViewModelTitle() {
        let viewModel = container.resolve(PlaceDetailsViewModelProtocol.self)!

        XCTAssertEqual(viewModel.title, "Budapest")
    }
}
