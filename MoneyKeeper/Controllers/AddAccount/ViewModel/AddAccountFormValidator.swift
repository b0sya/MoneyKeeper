//
//  AddAccountFormValidator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

struct AddAccountFormData {
    let uid: String
    let accountName: String
    let accountBalance: Double
}

final class AddAccountFormValidator: BaseFormValidator {
    
    let uid = UUID().uuidString
    
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
    
    var cleanData: AddAccountFormData? {
        guard let name = accountName,
              let balance = accountBalance else {
            return nil
        }
        return .init(uid: uid,
                     accountName: name,
                     accountBalance: balance)
    }
    
    override var validated: Bool {
        accountName != nil && accountBalance != nil
    }
}
