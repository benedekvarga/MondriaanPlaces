//
//  PlaceListViewController.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit

class PlaceListViewController: RootViewController, PlaceListViewControllerProtocol {
    // MARK: - Properties

    var viewModel: PlaceListViewModelProtocol {
        return rootViewModel as! PlaceListViewModelProtocol
    }

    // MARK: - RootViewController functions

    override func createView() -> UIView {
        let view = UIView()

        return view
    }

    override func initializeView() {
        super.initializeView()

        // Navigation Bar

        let logoImageView = UIImageView(image: UIImage(named: "mondriaanLogo".localized))
        debugLog("mondriaanLogo".localized)
        logoImageView.contentMode = .scaleAspectFill
        let imageItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
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
