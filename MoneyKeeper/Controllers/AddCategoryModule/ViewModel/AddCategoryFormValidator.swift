//
//  AddCategoryFormValidator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 11.04.2021.
//

import Foundation

struct AddCategoryFormData {
    let uid: String
    let categoryName: String
    let direction: DirectionType
    let parent: FCategory?
}

final class AddCategoryFormValidator: BaseFormValidator {
    
    let uid = UUID().uuidString
    
    var categoryName: String? {
        didSet {
            checkValidation()
        }
    }
    
    var parent: FCategory? {
        didSet {
            checkValidation()
        }
    }
    
    var direction: DirectionType? {
        didSet {
            checkValidation()
        }
    }
    
    var cleanData: AddCategoryFormData? {
        guard let name = categoryName,
              let direction = direction else {
            return nil
        }
        
        return .init(uid: uid,
                     categoryName: name,
                     direction: direction,
                     parent: parent)
    }
    
    override var validated: Bool {
        categoryName != nil
    }
}
