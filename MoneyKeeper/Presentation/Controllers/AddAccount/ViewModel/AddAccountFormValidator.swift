//
//  AddAccountFormValidator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

final class AddAccountFormValidator: BaseFormValidator {
    var accountName: String? {
        didSet {
            checkValidation()
        }
    }
    
    var accountBalance: Double? {
        didSet {
            checkValidation()
        }
    }
    
    override var validated: Bool {
        accountName != nil && accountBalance != nil
    }
    
    func save(completion: ParameterClosure<Result<Account, CoreDataError>>?) {
        guard let name = accountName,
              let balance = accountBalance else {
            //FIXME: FIX ERROR MESSAGE
            completion?(.failure(.saveContextError))
            return
        }
        
        StorageProvider.shared.isertAccount(name: name, currency: balance, icon: nil, completion: completion)
    }
}
