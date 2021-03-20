//
//  TransactionsListCellCOntainer.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 19.03.2021.
//

import UIKit

final class TransactionsListCellContainer<View: UIView & ConfigurableView>: ContainerTableCell<View> {
    override var contentInsets: UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

