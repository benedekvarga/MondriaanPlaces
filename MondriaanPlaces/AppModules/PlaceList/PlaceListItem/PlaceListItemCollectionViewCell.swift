//
//  PlaceListItemCollectionViewCell.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift
import UIKit

class PlaceListItemCollectionViewCell: RootCollectionViewCell {
    // MARK: - Properties

    private lazy var imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }

    private lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .mdcPurple
        $0.font = .rubikBold(ofSize: 14)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }

    private lazy var subtitleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .mdcGray
        $0.font = .rubikRegular(ofSize: 10)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

    private lazy var descriptionTextView = UITextView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = false
    }

    var viewModel: PlaceListItemViewModelProtocol! {
        didSet {
            setupView()
            bindViewModel()
        }
    }

    // MARK: - RootTableViewCell functions

    override func createView() {
        super.createView()

        customContentView.addSubview(imageView)
        customContentView.addSubview(titleLabel)
        customContentView.addSubview(subtitleLabel)
        customContentView.addSubview(descriptionTextView)
    }

    override func initializeView() {
        super.initializeView()

        backgroundColor = .mdcLightGray
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.top.left.equalToSuperview().offset(8)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView).offset(-3)
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-8)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.right.equalTo(titleLabel)
        }

        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.left.equalToSuperview().offset(8)
            $0.right.bottom.equalToSuperview().offset(-8)
        }
    }

    override func setupView() {
        super.setupView()

        titleLabel.text = viewModel.title.uppercased()
        subtitleLabel.text = viewModel.subtitle
        descriptionTextView.attributedText = viewModel.description.htmlAttributed(font: .rubikRegular, size: 8, color: .mdcDarkGray)

        viewModel.image
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
