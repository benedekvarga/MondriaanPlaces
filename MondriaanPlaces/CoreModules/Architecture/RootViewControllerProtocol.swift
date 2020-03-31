//
//  RootViewControllerProtocol.swift
//
//  Created by Benedek Varga on 2020. 03. 25..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit

protocol RootViewControllerProtocol: class {
    var rootViewModel: RootViewModelProtocol { get }
    var viewController: UIViewController { get }

    func createView() -> UIView
    func initializeView()
    func setupViewConstraints()
    func setupView()
    func bindViewModel()
}
