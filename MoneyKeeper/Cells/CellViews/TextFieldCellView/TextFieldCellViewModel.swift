//
//  TextFieldViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import UIKit

class TextFieldCellViewModel: NSObject {
    let title: String
    let value: String?
    let isRequired: Bool
    let isNumericField: Bool

    var onTextFieldEdited: ParameterClosure<String?>?

    var placeholder: String {
        isRequired ? .required : .notRequired
    }

    init(title: String,
         value: String? = nil,
         isRequired: Bool,
         isNumericField: Bool,
         onTextFieldEdited: ParameterClosure<String?>?) {
        self.title = title
        self.value = value
        self.isRequired = isRequired
        self.isNumericField = isNumericField
        self.onTextFieldEdited = onTextFieldEdited
    }
}
