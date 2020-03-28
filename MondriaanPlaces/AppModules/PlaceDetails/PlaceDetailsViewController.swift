//
//  PlaceDetailsViewController.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: RootViewController, PlaceDetailsViewControllerProtocol {
    // MARK: - Properties

    var viewModel: PlaceDetailsViewModelProtocol {
        return rootViewModel as! PlaceDetailsViewModelProtocol
    }

    // MARK: - RootViewController functions

    override func createView() -> UIView {
        let view = UIView()

        return view
    }

    override func initializeView() {
        super.initializeView()
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()
    }

    override func setupView() {
        super.setupView()
    }

    override func bindViewModel() {
        super.bindViewModel()

        // MARK: - ViewController

        // MARK: - ViewModel
    }
}
