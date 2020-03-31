//
//  DependencyInjection.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Swinject

class DependencyInjection {
    // MARK: - Properties

    static let shared = DependencyInjection()
    private let container: Container

    // MARK: - Initialization

    private init() {
        self.container = Container()
    }

    // MARK: - Functions

    func registerModules() {
        // MARK: - ViewModel

        container.register(PlaceListViewModelProtocol.self) { _ in
            return PlaceListViewModel()
        }

        container.register(PlaceDetailsViewModelProtocol.self) { (_, inputModel: RootInputModelProtocol) in
            return PlaceDetailsViewModel(inputView: inputModel)
        }

        // MARK: - ViewControllers

        container.register(PlaceListViewControllerProtocol.self) { (_, viewModel: PlaceListViewModelProtocol) in
            return PlaceListViewController(viewModel: viewModel)
        }

        container.register(PlaceDetailsViewControllerProtocol.self) { (_, viewModel: PlaceDetailsViewModelProtocol) in
            return PlaceDetailsViewController(viewModel: viewModel)
        }
    }

    // MARK: - ViewModel Resolvers

    private func resolvePlaceListViewModel() -> PlaceListViewModelProtocol {
        let viewModel = container.resolve(PlaceListViewModelProtocol.self)!

        return viewModel
    }

    private func resolvePlaceDetailsViewModel() -> PlaceDetailsViewModelProtocol {
        let inputModel: RootInputModelProtocol? = nil
        let viewModel = container.resolve(PlaceDetailsViewModelProtocol.self, argument: inputModel)!

        return viewModel
    }

    // MARK: - ViewController Resolvers

    func resolvePlaceListViewController() -> PlaceListViewControllerProtocol {
        let viewModel = resolvePlaceListViewModel()
        let viewController = container.resolve(PlaceListViewControllerProtocol.self, argument: viewModel)!

        return viewController
    }

    func resolveDetailsListViewController() -> PlaceDetailsViewControllerProtocol {
        let viewModel = resolvePlaceDetailsViewModel()
        let viewController = container.resolve(PlaceDetailsViewControllerProtocol.self, argument: viewModel)!

        return viewController
    }
}
