//
//  PlaceListItemViewModelProtocol.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

protocol PlaceListItemViewModelProtocol: RootViewModelProtocol {
    var title: String { get }
    var subtitle: String { get }
    var description: String { get }
    var image: BehaviorSubject<UIImage> { get }
    var itemSelected: (() -> Void) { get }
}
