//
//  RootTableViewCell.swift
//
//  Created by Benedek Varga on 2020. 03. 26..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit

class RootTableViewCell: UITableViewCell {
    // MARK: - Properties

    public var customContentView: UIView = {
        let customContentView = UIView()
        customContentView.translatesAutoresizingMaskIntoConstraints = false

        return customContentView
    }()

    var disposeBag = DisposeBag()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createView()
        initializeView()
        setNeedsUpdateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        disposeBag = DisposeBag()

        super.prepareForReuse()
    }

    override func updateConstraints() {
        super.updateConstraints()

        setupViewConstraints()
    }

    // MARK: - Functions

    /// Add UI components to `view` here.
    public func createView() {
        contentView.addSubview(customContentView)
    }

    /// Setup view properties independent from `viewModel`, for example title, backgroundColor
    public func initializeView() { }

    /// Define view components' constraints.
    public func setupViewConstraints() {
        customContentView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

    /// Setup static `view` properties vwith values from `viewModel`.
    public func setupView() { }

    /// Bind reactive properties between `view` and `viewController`.
    public func bindViewModel() { }
}
