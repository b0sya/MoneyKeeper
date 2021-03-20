//
//  ConfigurableView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 29.01.2021.
//

import Foundation

protocol ConfigurableView {
    associatedtype ViewModelType

    func configure(with viewModel: ViewModelType)
}
