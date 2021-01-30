//
//  RxViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//

import Foundation
import RxSwift

class RxViewModel {
    
    let disposeBag = DisposeBag()

    init() {
        configure()
        bind()
    }

    // MARK: - Life cycle

    func configure() {
        // empty for subclasses overriding
    }

    func bind() {
        // empty for subclasses overriding
    }
}
