//
//  AddAccountViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 03.02.2021.
//

import Foundation

final class AddAccountViewModel: AddAccountBuilderDataSource {

    weak var view: AddAccountViewController?

    var accountName: String?
    var accountBalance: Double?

    var onAccountNameEntered: ParameterClosure<String?>?
    var onAccountBalanceEntered: ParameterClosure<String?>?

    var textFieldViewModels: [TextFieldCellViewModel] = []

    var buttonCellViewModel = ButtonCellViewModel(buttonTitle: "Готово", buttonAction: nil)

    init() {
        onAccountNameEntered = { [weak self] text in
            self?.accountName = text
        }

        onAccountBalanceEntered = { [weak self] text in
            guard let value = text else {
                return
            }
            self?.accountBalance = Double(value)
        }

        createTextFieldViewModels()
    }

    private func createTextFieldViewModels() {
        textFieldViewModels = [
            TextFieldCellViewModel(title: "Название",
                               isRequired: true,
                               isNumericField: false,
                               onTextFieldEdited: onAccountNameEntered),
            TextFieldCellViewModel(title: "Баланс",
                               isRequired: false,
                               isNumericField: true,
                               onTextFieldEdited: onAccountBalanceEntered)

        ]

        buttonCellViewModel.buttonAction = { [weak self] in
            guard let name = self?.accountName,
                  !name.isEmpty else {
                self?.view?.showError(message: "Заполнены не все обязательные поля")
                return
            }
            var currency: Double?
            if let balance = self?.accountBalance {
                currency = Double(balance)
            }

            StorageProvider.shared.isertAccount(name: name, currency: currency, icon: nil) { [weak self] result in
                switch result {
                case .success(let result):
                    self?.view?.onFinish?(result)
                case .failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
                }
            }

        }

    }

}
