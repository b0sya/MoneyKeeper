//
//  AddTransactionFormValidator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 07.03.2021.
//

import Foundation

struct AddTransactionFormData {
    let uid: String
    let direction: DirectionType
    var mainAmount: Double
    let presentedAmount: Double
    let currency: Currency
    let description: String?
    let category: FCategory
    let date: Date
    let account: FAccount
}

final class AddTransactionFormValidator: BaseFormValidator {
    let uid = UUID().uuidString
    
    var direction: DirectionType? = .cost {
        didSet {
            checkValidation()
        }
    }
    var amount: Double? {
        didSet {
            checkValidation()
        }
    }
    var currency: Currency? = .RUB {
        didSet {
            checkValidation()
        }
    }
    var description: String? {
        didSet {
            checkValidation()
        }
    }
    var category: FCategory? {
        didSet {
            checkValidation()
        }
    }
    var date: Date = Date() {
        didSet {
            checkValidation()
        }
    }
    
    var account: FAccount? {
        didSet {
            checkValidation()
        }
    }
    
    var cleanData: AddTransactionFormData? {
        guard let amount = self.amount,
              let category = self.category,
              let account = self.account,
              let direction = self.direction,
              let currency = currency else {
            return nil
        }
        return .init(uid: uid,
                     direction: direction,
                     mainAmount: amount,
                     presentedAmount: amount,
                     currency: currency,
                     description: description,
                     category: category,
                     date: date,
                     account: account)
    }
    
    override var validated: Bool {
        amount != nil && category != nil && account != nil
    }
}
