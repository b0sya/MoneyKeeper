//
//  TransactionCellViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class TransactionCellViewModel: AccountCellViewModel {
    var cornerMask: CACornerMask?
    
    init(title: String,
         value: NSAttributedString,
         tapAction: VoidClosure?,
         cornerMask: CACornerMask? = nil) {
        super.init(title: title, attributedValue: value, icon: nil, tapAction: tapAction)
        
        self.cornerMask = cornerMask
    }
    
    convenience init(transaction: FTransaction, cornerMask: CACornerMask? = nil, tapAction: VoidClosure?) {
        let date = DateFormatter.dayMonthWordYearTimeFormatter.string(from: transaction.date)
        let amountString = NumberFormatter.rubFormatter.string(from: NSNumber(value: transaction.amount)) ?? "!ERROR!"
        let amountColor = transaction.isCostOperation ? UIColor.red : UIColor.MKGreen
        
        let amount = transaction.isCostOperation ? "-\(amountString)" : "+\(amountString)"
                
        self.init(title: date,
                  value: NSAttributedString(string: amount, attributes: [NSAttributedString.Key.foregroundColor: amountColor]),
                  tapAction: tapAction)
        
        self.cornerMask = cornerMask
    }
}
