//
//  RootViewModelProtocol.swift
//
//  Created by Benedek Varga on 2020. 03. 27..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift

protocol RootViewModelProtocol {
    var disposeBag: DisposeBag { get }

    func initializeViewModel()
}
