//
//  Transactions+DirectionType.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 07.03.2021.
//

enum DirectionType: Int16 {
    case income = 0
    case cost
}

extension Transaction {
    var directionType: DirectionType {
        if self.direction == 1 {
            return .cost
        } else {
            return .income
        }
    }
}
