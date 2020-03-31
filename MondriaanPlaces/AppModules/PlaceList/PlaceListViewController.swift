//
//  PlaceListViewController.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class PlaceListViewController: RootViewController, PlaceListViewControllerProtocol {
    // MARK: - Types

    private struct PrivateConstants {
        private static let screenWidth = UIScreen.main.bounds.width
        private static let cellWidth: CGFloat = (PrivateConstants.screenWidth / 2) - (PrivateConstants.leftPadding) - (PrivateConstants.rightPadding)
        private static let topPadding: CGFloat = 0
        private static let leftPadding: CGFloat = 4
        private static let bottomPadding: CGFloat = 8
        private static let rightPadding: CGFloat = 4

        static let cellSize: CGSize = CGSize(width: PrivateConstants.cellWidth, height: PrivateConstants.cellWidth)
        static let cellEdgeInsets = UIEdgeInsets(
            top: PrivateConstants.topPadding,
            left: PrivateConstants.leftPadding,
            bottom: PrivateConstants.bottomPadding,
            right: PrivateConstants.rightPadding)
        static let minimumLineSpacing = PrivateConstants.bottomPadding
        static let sectionHeaderSize = CGSize(width: PrivateConstants.screenWidth, height: 56)
    }

    // MARK: - Typealiases

    typealias PlacesSection = AnimatableSectionModel<String, PlaceListItemViewModel>

    // MARK: - Datasources

    private lazy var dataSource = RxCollectionViewSectionedAnimatedDataSource<PlacesSection>(
        configureCell: { _, collectionView, indexPath, viewModel in
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceListItemCollectionViewCell.reuseIdentifier, for: indexPath)
                    as? PlaceListItemCollectionViewCell
                else { return .init() }

            cell.viewModel = viewModel
            return cell
        },
        configureSupplementaryView: { _, collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath) as? SectionHeaderView
            else {
                return .init()
            }

            let headerViewModel = self.viewModel.sectionHeaders[indexPath.section]
            header.viewModel = headerViewModel

            return header
        })

    // MARK: - Properties

    var viewModel: PlaceListViewModelProtocol {
        return rootViewModel as! PlaceListViewModelProtocol
    }

    private lazy var refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil).then {
        $0.tintColor = .black
    }

    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.sectionInset = PrivateConstants.cellEdgeInsets
        $0.minimumLineSpacing = PrivateConstants.minimumLineSpacing
        $0.minimumInteritemSpacing = 0
        $0.itemSize = PrivateConstants.cellSize
        $0.headerReferenceSize = PrivateConstants.sectionHeaderSize
    }

    private lazy var placeListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.isPagingEnabled = false
        $0.clipsToBounds = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.register(PlaceListItemCollectionViewCell.self, forCellWithReuseIdentifier: PlaceListItemCollectionViewCell.reuseIdentifier)
        $0.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
    }

    private lazy var placeholderLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .rubikBold(ofSize: 22)
        $0.textColor = .mdcPurple
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.isHidden = true
    }

    // MARK: - RootViewController functions

    override func createView() -> UIView {
        let view = UIView()

        view.addSubview(placeholderLabel)
        view.addSubview(placeListCollectionView)

        return view
    }

    override func initializeView() {
        super.initializeView()

        // View

        view.backgroundColor = .white

        // Navigation Bar

        let logoImageView = UIImageView(image: UIImage(named: "mondriaanLogo".localized))
        logoImageView.contentMode = .scaleAspectFill
        let imageItem = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
        navigationItem.rightBarButtonItem = refreshButton
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func setupViewConstraints() {
        super.setupViewConstraints()

        placeholderLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(64)
            $0.right.equalToSuperview().offset(-64)
            $0.centerY.equalToSuperview().offset(-64)
        }

        placeListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func setupView() {
        super.setupView()

        placeholderLabel.text = viewModel.placeholderText
    }

    override func bindViewModel() {
        super.bindViewModel()

        // MARK: - ViewController

        refreshButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.onReload()
            })
        .disposed(by: disposeBag)

        placeListCollectionView.rx.modelSelected(PlaceListItemViewModel.self)
            .subscribe(onNext: { item in
                item.itemSelected()
            })
            .disposed(by: disposeBag)

        // MARK: - ViewModel

        viewModel.places
            .map { items in
                var places: [PlacesSection] = []

                for i in 0..<items.count {
                    let id = "section-\(i)"
                    let sectionModel = PlacesSection(model: id, items: items[i].map { $0 as! PlaceListItemViewModel })
                    places.append(sectionModel)
                }

                return places
            }
            .bind(to: placeListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.places
            .skip(1)
            .map { $0.isEmpty }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEmpty in
                guard let self = self else { return }

                self.placeListCollectionView.isHidden = isEmpty
                self.placeholderLabel.isHidden = !isEmpty
            })
            .disposed(by: disposeBag)
    }
}
