//
//  ContainerView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import UIKit

class RoundedContainerCellView: BaseView {
    override func configureAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 8
    }
}
