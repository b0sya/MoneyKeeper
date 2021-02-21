//
//  AddTransactionViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

final class AddTransactionViewModel: AddTransactionBuilderDataSource {
    weak var view: AddTransactionViewController?
    
    var currencyCellViewModel = TextFieldCellViewModel(title: "Сумма",
                                                   isRequired: true,
                                                   isNumericField: true,
                                                   onTextFieldEdited: nil)

    var descriptionCellViewModel = TextFieldCellViewModel(title: "Описание",
                                                      isRequired: false,
                                                      isNumericField: false,
                                                      onTextFieldEdited: nil)

    var categoryCellViewModel = SelectCellViewModel(title: "Категория",
                                                    isRequired: true,
                                                    tapAction: nil)

    var dateCellViewModel: TextFieldCellViewModel = TextFieldCellViewModel(title: "Дата",
                                                                   isRequired: true,
                                                                   isNumericField: false,
                                                                   onTextFieldEdited: nil)

    var enteredCurrency: String?

}
