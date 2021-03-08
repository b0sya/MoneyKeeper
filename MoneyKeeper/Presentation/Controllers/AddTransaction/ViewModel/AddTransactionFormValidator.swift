//
//  AddTransactionFormValidator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 07.03.2021.
//

import Foundation

final class AddTransactionFormValidator: BaseFormValidator {
    var direction: DirectionType? = .income {
        didSet {
            checkValidation()
        }
    }
    var amount: Double? {
        didSet {
            checkValidation()
        }
    }
    var description: String? {
        didSet {
            checkValidation()
        }
    }
    var category: Category? {
        didSet {
            checkValidation()
        }
    }
    var date: Date = Date() {
        didSet {
            checkValidation()
        }
    }
    
    var account: Account? {
        didSet {
            checkValidation()
        }
    }
    
    override var validated: Bool {
        amount != nil && category != nil && account != nil
    }
    
    func save(completion: ParameterClosure<Result<Transaction, CoreDataError>>?) {
        guard let amount = self.amount,
              let category = self.category,
              let account = self.account,
              let direction = self.direction?.rawValue else {
            completion?(.failure(.saveContextError))
            return
        }
        
        StorageProvider.shared.insertTransaction(amount: amount,
                                                 category: category,
                                                 date: date,
                                                 description: description,
                                                 account: account,
                                                 direction: direction,
                                                 completion: completion)
    }
}
