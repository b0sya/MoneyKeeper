//
//  NumberFormatter+RUB.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 20.03.2021.
//

import Foundation

extension NumberFormatter {
//    static let rub: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.locale = Locale(identifier: "ru_RU")
//        formatter.numberStyle = .currency
//        
//        return formatter
//    }()
//    
//    static let eur: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.locale = Locale(identifier: "ru_RU")
//        formatter.numberStyle = .currency
//        
//        return formatter
//    }()
    
    static let perscntage: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        return formatter
    }()
}
