//
//  TransactionCellViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class TransactionCellViewModel: AccountCellViewModel {
    let cornerMask: CACornerMask?
    let description: String?
    let time: String
    let accountName: String
    let showAccountName: Bool
    
    init(transaction: FTransaction,
         showAccountName: Bool = false,
         cornerMask: CACornerMask? = nil,
         tapAction: VoidClosure?) {
        let time = DateFormatter.timeFormatter.string(from: transaction.date)
        let amountString = transaction.presentAmount.formatAsCurrency(currencyCode: transaction.currency.bankCode) ?? ""
        let amountColor = transaction.isCostOperation ? UIColor.red : UIColor.MKGreen
        
        let amount = transaction.isCostOperation ? "-\(amountString)" : "+\(amountString)"
        
        self.cornerMask = cornerMask
        self.description = transaction.note
        self.time = time
        self.accountName = transaction.relatedAccount.name
        self.showAccountName = showAccountName
        
        super.init(title: transaction.relatedCategory.localizedName,
                   attributedValue: NSAttributedString(string: amount,
                                                       attributes: [NSAttributedString.Key.foregroundColor: amountColor]),
                   icon: nil,
                   tapAction: tapAction)
    }
}
