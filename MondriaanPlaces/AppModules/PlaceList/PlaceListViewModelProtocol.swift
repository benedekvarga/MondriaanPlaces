//
//  PlaceListViewModelProtocol.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift

protocol PlaceListViewModelProtocol: RootViewModelProtocol {
    var isOffline: BehaviorSubject<Bool> { get }
    var places: BehaviorSubject<[[PlaceListItemViewModelProtocol]]> { get }
    var sectionHeaders: [SectionHeaderViewModelProtocol] { get }
    var placeholderText: BehaviorSubject<String> { get }
    var onReload: (() -> Void) { get }
}
