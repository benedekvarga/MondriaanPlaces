//
//  PlaceDetailsViewController.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceDetailsViewController: RootViewController, PlaceDetailsViewControllerProtocol {
    // MARK: - Properties

    private lazy var mapView = GMSMapView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: nil, action: nil).then {
        $0.tintColor = .mdcYellow
        $0.onTap { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    // MARK: - PlaceDetailsViewControllerProtocol properties

    var viewModel: PlaceDetailsViewModelProtocol {
        return rootViewModel as! PlaceDetailsViewModelProtocol
    }

    // MARK: - RootViewController functions

    override func createView() -> UIView {
        let view = UIView()

        view.addSubview(mapView)

        return view
    }

    override func initializeView() {
        super.initializeView()

        title = viewModel.title

        // Navigation Bar
        navigationItem.leftBarButtonItem = backButton

        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.mdcPurple,
            NSAttributedString.Key.font: UIFont.rubikBold(ofSize: 22)
        ]
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()

        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setupView() {
        super.setupView()

        viewModel.pins.forEach { pin in
            let marker = GMSMarker()
            marker.position = pin.coordinates
            marker.title = pin.name
            marker.snippet = pin.city
            marker.map = mapView
        }

        // Position the view of map

        let centerPoint = viewModel.pins.map { $0.coordinates }.center()
        let camera = GMSCameraPosition.camera(withLatitude: centerPoint.latitude, longitude: centerPoint.longitude, zoom: 10.0)
        mapView.camera = camera
    }
}
