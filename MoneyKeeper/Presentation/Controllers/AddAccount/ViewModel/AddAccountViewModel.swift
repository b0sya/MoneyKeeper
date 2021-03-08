//
//  AddAccountViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 03.02.2021.
//

import Foundation

final class AddAccountViewModel {
    weak var view: AddAccountViewController?
    
    var buttonCellViewModel = ButtonCellViewModel(buttonTitle: .done)
    
    private let validator = AddAccountFormValidator()
    
    init() {
        validator.delegate = self
        
        buttonCellViewModel.buttonAction = { [weak validator] in
            validator?.save { [weak self] result in
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

extension AddAccountViewModel: AddAccountBuilderDataSource {
    var textFieldViewModels: [TextFieldCellViewModel] {
        [
            .accountName(onTextFieldEdited: { [weak validator] text in
                validator?.accountName = text
            }),
            .balance(onTextFieldEdited: { [weak validator] text in
                validator?.accountBalance = Double(text ?? "")
            })
        ]
    }
}

extension AddAccountViewModel: FormValidatorDelegate {
    func wasSuccessed() {
        buttonCellViewModel.isEnabled = true
    }
    
    func wasFailed() {
        buttonCellViewModel.isEnabled = false
    }
    
    
}
