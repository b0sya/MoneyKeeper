//
//  AccountCellViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import UIKit

final class AccountCellViewModel: DefaultCellViewModel {
    let currencyValue: String

    init(title: String,
         value: Double,
         icon: UIImage?,
         tapAction: VoidClosure?
    ) {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: value as NSNumber) {
            currencyValue = formattedTipAmount
        }
        else {
            currencyValue = "!ERROR!"
        }

        super.init(title: title, icon: icon, tapAction: tapAction)
    }
}
