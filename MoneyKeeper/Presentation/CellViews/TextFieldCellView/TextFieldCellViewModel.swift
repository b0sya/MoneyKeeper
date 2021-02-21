//
//  TextFieldViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import UIKit

class TextFieldCellViewModel: NSObject {
    let title: String
    let isRequired: Bool
    let isNumericField: Bool

    let onTextFieldEdited: ParameterClosure<String?>?

    var placeholder: String {
        isRequired ? .requiredFieldPlaceholder : .notRequiredFieldPlaceholder
    }

    init(title: String,
         isRequired: Bool,
         isNumericField: Bool,
         onTextFieldEdited: ParameterClosure<String?>?) {
        self.title = title
        self.isRequired = isRequired
        self.isNumericField = isNumericField
        self.onTextFieldEdited = onTextFieldEdited
    }
}
