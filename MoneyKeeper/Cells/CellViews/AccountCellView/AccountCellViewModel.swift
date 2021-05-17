//
//  AccountCellViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import UIKit

class AccountCellViewModel: DefaultCellViewModel {
    let currencyValue: NSAttributedString

    init(title: String,
         value: Double,
         icon: UIImage?,
         tapAction: VoidClosure?
    ) {
        if let formattedTipAmount = value.formatAsCurrency(currencyCode: Currency.RUB.bankCode) {
            currencyValue = NSAttributedString(string: formattedTipAmount)
        }
        else {
            currencyValue = NSAttributedString(string: "!ERROR!")
        }

        super.init(title: title, icon: icon, tapAction: tapAction)
    }
    
    init(title: String,
         attributedValue: NSAttributedString,
         icon: UIImage?,
         tapAction: VoidClosure?
    ) {
        self.currencyValue = attributedValue
        super.init(title: title, icon: icon, tapAction: tapAction)
    }
}
