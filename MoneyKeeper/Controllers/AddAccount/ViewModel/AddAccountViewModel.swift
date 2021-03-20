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
    private let firebaseStorage = FirebaseStorage.instance
    
    init() {
        validator.delegate = self
        
        buttonCellViewModel.buttonAction = { [weak self] in
            self?.saveAccount()
        }
    }
    
    private func saveAccount() {
        guard let formData = validator.cleanData else {
            return
        }
        view?.showActivityIndicator()
        firebaseStorage.addAccount(uid: formData.uid, name: formData.accountName, balance: formData.accountBalance) { [weak self] result in
            self?.view?.hideActivityIndicator()
            switch result {
            case .success(_):
                self?.view?.onFinish?()
            case .failure(let error):
                self?.view?.showError(message: error.localizedDescription)
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
