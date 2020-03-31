//
//  PlaceListItemViewModel.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

class PlaceListItemViewModel: RootViewModel, PlaceListItemViewModelProtocol {
    // MARK: - PlaceListItemViewModelProtocol properties

    let title: String
    let subtitle: String
    var description: String
    let image = BehaviorSubject<UIImage>(value: #imageLiteral(resourceName: "photoPlacehoder"))
    let itemSelected: (() -> Void)

    // MARK: - Properties

    private let imageUrl: String

    init(inputView: PlaceListItemInputModelProtocol) {
        self.title = inputView.title
        self.subtitle = inputView.subtitle
        self.description = inputView.description
        self.itemSelected = inputView.itemSelected
        self.imageUrl = inputView.imageUrl

        super.init(inputView: inputView)
    }

    override func initializeViewModel() {
        super.initializeViewModel()

        downloadImage(from: imageUrl)
    }

    private func downloadImage(from urlString: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard
                let self = self,
                let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")),
                let data = try? Data(contentsOf: url),
                let downloadedImage = UIImage(data: data)
            else {
                errorLog("Cannot get image from URL:", urlString)
                return
            }
            DispatchQueue.main.async {
                self.image.onNext(downloadedImage)
            }
        }
    }
}

extension PlaceListItemViewModel: Equatable {
    static func == (lhs: PlaceListItemViewModel, rhs: PlaceListItemViewModel) -> Bool {
        return
            lhs.title == rhs.title &&
            lhs.subtitle == rhs.subtitle &&
            lhs.description == rhs.description
    }
}

extension PlaceListItemViewModel: IdentifiableType {
    typealias Identity = String

    var identity: String {
        return "\(title)-\(subtitle)"
    }
}
