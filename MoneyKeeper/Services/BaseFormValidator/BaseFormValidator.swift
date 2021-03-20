//
//  BaseFormValidator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

class BaseFormValidator {
    weak var delegate: FormValidatorDelegate?
    
    var validated: Bool {
        fatalError("Need to override \"validated\" abstract property")
    }
    
    func checkValidation() {
        guard validated else {
            delegate?.wasFailed()
            return
        }
        
        delegate?.wasSuccessed()
    }
}

protocol FormValidatorDelegate: class {
    func wasSuccessed()
    func wasFailed()
}
