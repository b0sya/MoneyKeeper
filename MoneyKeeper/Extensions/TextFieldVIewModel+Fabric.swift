//
//  TextFieldVIewModel+Fabric.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

extension TextFieldCellViewModel {
    static func accountName(onTextFieldEdited: ParameterClosure<String?>? = nil) -> TextFieldCellViewModel {
        .init(title: .title,
              isRequired: true,
              isNumericField: false,
              onTextFieldEdited: onTextFieldEdited)
    }
    
    static func balance(onTextFieldEdited: ParameterClosure<String?>? = nil) -> TextFieldCellViewModel {
        .init(title: .balance,
              isRequired: true,
              isNumericField: true,
              onTextFieldEdited: onTextFieldEdited)
    }
    
    static func value(onTextFieldEdited: ParameterClosure<String?>? = nil) -> TextFieldCellViewModel {
        .init(title: .sum,
              isRequired: true,
              isNumericField: true,
              onTextFieldEdited: onTextFieldEdited)
    }
    
    static func description(onTextFieldEdited: ParameterClosure<String?>? = nil) -> TextFieldCellViewModel {
        .init(title: .description,
              isRequired: false,
              isNumericField: false,
              onTextFieldEdited: nil)
    }
}
