//
//  TransactionCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class TransactionCellView: AccountCellView {
    override func configure(with viewModel: DefaultCellViewModel) {
        super.configure(with: viewModel)
        
        guard let transactionCellViewModel = viewModel as? TransactionCellViewModel else {
            return
        }
        
        if let cornerMask = transactionCellViewModel.cornerMask {
            layer.maskedCorners = cornerMask
            layer.cornerRadius = 8
        } else {
            layer.cornerRadius = 0
        }
    }
}
