//
//  SectionHeaderView.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 29..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Closures
import UIKit

class SectionHeaderView: UICollectionReusableView {
    // MARK: - Properties

    private lazy var backgroundView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .mdcPurple
    }

    private lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .rubikRegular(ofSize: 18)
        $0.textColor = .mdcYellow
        $0.textAlignment = .left
    }

    private lazy var pinImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .mdcYellow
        $0.contentMode = .scaleAspectFit
        $0.image = #imageLiteral(resourceName: "marker")
    }

    var viewModel: SectionHeaderViewModelProtocol! {
        didSet {
            setupView()
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        createView()
        initializeView()
        setupView()
        setNeedsUpdateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func updateConstraints() {
        super.updateConstraints()

        setupViewConstraints()
    }

    // MARK: - Functions

    private func createView() {
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(pinImageView)
    }

    private func initializeView() {
        backgroundColor = .clear
    }

    private func setupViewConstraints() {
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }

        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }

        pinImageView.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }

    private func setupView() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title

        self.addTapGesture(handler: { _ in
            viewModel.onTap()
        })
    }
}
