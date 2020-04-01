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

    var sectionHeaders = [SectionHeaderViewModelProtocol]()

    let placeholderText = "reloadText".localized
    let places = BehaviorSubject<[[PlaceListItemViewModelProtocol]]>(value: [])

    lazy var onReload: (() -> Void) = { [weak self] in
        self?.downloadPlaces()
    }

    // MARK: - Properties

    private let placesService: PlacesServiceProtocol
    private let placesList = BehaviorSubject<[Place]>(value: [])

    // MARK: - Initialization

    init(placesService: PlacesServiceProtocol) {
        self.placesService = placesService

        super.init()
    }

    // MARK: - PlaceListViewModelProtocol functions

    override func initializeViewModel() {
        super.initializeViewModel()

        placesList
            .map { [weak self] places in
                guard let self = self else { return [[]] }

                let placesByCity = self.splitByCities(places: places)
                self.sectionHeaders = self.createSectionHeaderViewModels(from: placesByCity)

                return self.createPlaceListItemViewModels(from: placesByCity)
            }
            .bind(to: places)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        super.loadData()

        downloadPlaces()
    }

    // MARK: - Functions

    private func splitByCities(places: [Place]) -> [[Place]] {
        let splitPlaces = Set(places.map { $0.city }).map { item in
            return places.filter { $0.city == item }
        }

        return splitPlaces
    }

    private func createSectionHeaderViewModels(from placesByCity: [[Place]]) -> [SectionHeaderViewModelProtocol] {
        let viewModels: [SectionHeaderViewModelProtocol] = placesByCity.map { places in
            let inputModel = SectionHeaderInputModel(title: places.first?.city ?? "", itemSelected: {
                return PlaceDetailsInputModel(
                    title: places.first?.city ?? "",
                    pins: places.map { PinModel(name: $0.name, city: $0.city, coordinates: $0.coordinates) })
            })

            return SectionHeaderViewModel(inputView: inputModel)
        }

        return viewModels
    }

    private func createPlaceListItemViewModels(from placesByCity: [[Place]]) -> [[PlaceListItemViewModelProtocol]] {
        let viewModel: [[PlaceListItemViewModelProtocol]] = placesByCity.map { places in
            return places.map { place in
                let inputView = PlaceListItemInputModel(
                    title: place.name,
                    subtitle: place.address,
                    description: place.description,
                    imageUrl: place.imageUrl,
                    itemSelected: {
                        return PlaceDetailsInputModel(
                            title: place.name,
                            pins: [PinModel(name: place.name, city: place.city, coordinates: place.coordinates)]
                        )
                    }
                )

                return PlaceListItemViewModel(inputView: inputView)
            }
        }

        return viewModel
    }

    private func downloadPlaces() {
        placesService.download()
            .asObservable()
            .subscribe(onNext: { [weak self] places in
                self?.placesList.onNext(places)
            })
            .disposed(by: disposeBag)
    }
}
