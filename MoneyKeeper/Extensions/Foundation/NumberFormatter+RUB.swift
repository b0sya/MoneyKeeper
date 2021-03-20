//
//  NumberFormatter+RUB.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 20.03.2021.
//

import Foundation

extension NumberFormatter {
    static let rubFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        
        return formatter
    }()
}
