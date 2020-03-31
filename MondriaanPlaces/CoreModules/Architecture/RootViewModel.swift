//
//  RootViewModel.swift
//
//  Created by Benedek Varga on 2020. 03. 27..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import RxSwift

public class RootViewModel: RootViewModelProtocol {
    // MARK: - Properties

    let disposeBag: DisposeBag = DisposeBag()

    // MARK: - Initialization

    public init(inputView: RootInputModelProtocol) {
        initializeViewModel()
    }
    public init() {
        initializeViewModel()
    }

    // MARK: - RootViewModelProtocol functions

    func initializeViewModel() { }
}
