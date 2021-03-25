//
//  TransactionCellViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class TransactionCellViewModel: AccountCellViewModel {
    var cornerMask: CACornerMask?
    var categoryName: String
    var description: String?
    
    init(transaction: FTransaction, cornerMask: CACornerMask? = nil, tapAction: VoidClosure?) {
        let date = DateFormatter.dayMonthWordYearTimeFormatter.string(from: transaction.date)
        let amountString = NumberFormatter.rubFormatter.string(from: NSNumber(value: transaction.amount)) ?? "!ERROR!"
        let amountColor = transaction.isCostOperation ? UIColor.red : UIColor.MKGreen
        
        let amount = transaction.isCostOperation ? "-\(amountString)" : "+\(amountString)"
        
        self.cornerMask = cornerMask
        self.categoryName = transaction.relatedCategory.localizedName
        self.description = transaction.note
        
        super.init(title: date,
                   attributedValue: NSAttributedString(string: amount, attributes: [NSAttributedString.Key.foregroundColor: amountColor]),
                   icon: nil,
                   tapAction: tapAction)
    }
}
