//
//  AddCategoryViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 17.04.2021.
//

import Foundation

final class AddCategoryViewModel: AddCategoryBuilderDataSource {
    private let validator = AddCategoryFormValidator()
    private let firebaseStorage = FirebaseStorage.instance
    
    let nameCellViewModel = TextFieldCellViewModel(title: .title,
                                                   isRequired: true,
                                                   isNumericField: false,
                                                   onTextFieldEdited: nil)
    
    let parentCategorySelectViewModel = SelectCellViewModel(title: .parent,
                                                            value: nil,
                                                            isRequired: false)
    
    let doneButtonViewModel = ButtonCellViewModel(buttonTitle: .done)
    let directionsViewModel: SegmentedControlCellViewModel
    
    weak var view: AddCategoryModuleInput?
    
    init() {
        validator.direction = .cost
        
        directionsViewModel = SegmentedControlCellViewModel(segmentTitles: [.expense, .income],
                                                            selectedIndex: Int(validator.direction?.rawValue ?? 0))
        
        validator.delegate = self
        bind()
    }
        
    private func bind() {
        nameCellViewModel.onTextFieldEdited = { [weak validator] in
            validator?.categoryName = $0
        }
        
        directionsViewModel.onChangedSegmentedIndex = { [weak validator] index in
            validator?.direction = DirectionType(rawValue: Int16(index))
        }
        
        parentCategorySelectViewModel.onTap = { [weak self] in
            guard let direction = self?.validator.direction else {
                return
            }
            let inputData = CategoriesListInputData(direction: direction) { [weak self] in
                self?.validator.parent = $0
                self?.parentCategorySelectViewModel.value = $0.localizedName
            }
            self?.view?.onParentCategoryTap?(inputData)
        }
        
        doneButtonViewModel.buttonAction = { [weak self] in
            self?.addCategory()
        }
    }
    
    private func addCategory() {
        guard let data = validator.cleanData else {
            return
        }
        view?.showActivityIndicator()
        firebaseStorage.addCategory(name: data.categoryName,
                                    direction: data.direction,
                                    parent: data.parent) { [weak self] result in
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

extension AddCategoryViewModel:  FormValidatorDelegate {
    func wasSuccessed() {
        doneButtonViewModel.isEnabled = true
    }
    
    func wasFailed() {
        doneButtonViewModel.isEnabled = false
    }
}
