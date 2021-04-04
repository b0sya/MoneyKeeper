//
//  Statistics.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation

struct Report {
    let costs: Double
    let incomes: Double
    
    var periodBalance: Double {
        incomes - costs
    }
}
