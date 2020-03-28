//
//  RootViewController.swift
//
//  Created by Benedek Varga on 2020. 03. 25..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: UIViewController, RootViewControllerProtocol {
    // MARK: - Properties

    var rootViewModel: RootViewModelProtocol
    let disposeBag = DisposeBag()

    var viewController: UIViewController {
        return self
    }

    // MARK: - Initialization

    init(viewModel: RootViewModelProtocol) {
        self.rootViewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()

        view = createView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        setupViewConstraints()
    }

    // MARK: - Functions

    /// Add UI components to `view` here.
    public func createView() -> UIView {
        return UIView()
    }

    /// Setup view properties independent from `viewModel`, for example title, backgroundColor, etc.
    public func initializeView() {
        view.backgroundColor = .white

        setupView()
        bindViewModel()
    }

    /// Define view components' constraints.
    public func setupViewConstraints() { }

    /// Setup static `view` properties vwith values from `viewModel`.
    func setupView() { }

    /// Bind reactive properties between `view` and `viewController`.
    func bindViewModel() { }
}
