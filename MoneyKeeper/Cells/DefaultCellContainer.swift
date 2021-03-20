//
//  DefaultCellContainer.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 29.01.2021.
//

import UIKit

final class DefaultCellContainer<View: UIView & ConfigurableView>: ContainerTableCell<View> {
    override var contentInsets: UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 8, right: 16)
    }
}
