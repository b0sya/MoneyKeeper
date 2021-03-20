//
//  AddTransactionViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

final class AddTransactionViewModel: AddTransactionBuilderDataSource {
    weak var view: AddTransactionViewController?
    
    private let validator = AddTransactionFormValidator()
    private let transactionTypeTitles = ["Расход", "Доход"]
    private let firebaseStorage = FirebaseStorage.instance
    
    let currencyCellViewModel: TextFieldCellViewModel = .value()
    let descriptionCellViewModel: TextFieldCellViewModel = .description()
    let categoryCellViewModel: SelectCellViewModel = .init(title: .category,
                                                           value: nil,
                                                           isRequired: true)
    let accountCellViewModel: SelectCellViewModel = .init(title: .account,
                                                           value: nil,
                                                           isRequired: true)
    let dateCellViewModel: DatePickerCellViewModel
    
    let buttonCellViewModel = ButtonCellViewModel(buttonTitle: .done)
    let transactionTypeViewModel: SegmentedControlCellViewModel
    
    var selectedCategory: Category? {
        didSet {
            categoryCellViewModel.value = selectedCategory?.name
        }
    }
    
    init() {
        transactionTypeViewModel = .init(segmentTitles: transactionTypeTitles, selectedIndex: Int(validator.direction?.rawValue ?? 0))
        dateCellViewModel = .init(title: .date,
                                  value: DateFormatter.dayMonthWordYearTimeFormatter.string(from: validator.date),
                                  isRequired: true,
                                  isNumericField: false,
                                  onTextFieldEdited: nil)
        
        validator.delegate = self
        
        bind()
    }
    
    private func bind() {
        transactionTypeViewModel.onChangedSegmentedIndex = { [weak self] in
            self?.validator.direction = DirectionType(rawValue: Int16($0))
            self?.validator.category = nil
            self?.categoryCellViewModel.value = nil
        }
        currencyCellViewModel.onTextFieldEdited = { [weak validator] string in
            validator?.amount = Double(string ?? "")
        }
        
        descriptionCellViewModel.onTextFieldEdited = { [weak validator] string in
            validator?.description = string
        }
        
        categoryCellViewModel.onTap = { [ weak self] in
            guard let direction = self?.validator.direction else { return }

            let input = CategoryListInput(direction: direction) { [weak self] in
                self?.validator.category = $0
                self?.categoryCellViewModel.value = $0.localizedName
            }
            self?.view?.onCategoryTap?(input)
        }
        
        accountCellViewModel.onTap = { [ weak self] in
            self?.view?.onAccountTap? { [weak self] in
                self?.validator.account = $0
                self?.accountCellViewModel.value = $0.name
            }
        }
        
        dateCellViewModel.onDatePickerDonePressed = { [weak validator] date in
            validator?.date = date
        }
        
        buttonCellViewModel.buttonAction = { [weak self] in
            self?.saveTransaction()
            
        }
    }
    
    private func saveTransaction() {
        guard let data = validator.cleanData else {
            return
        }
        view?.showActivityIndicator()
        firebaseStorage.addTransaction(data: data) { [weak self] result in
            self?.view?.hideActivityIndicator()
            switch result {
            case .success(_):
                self?.view?.onFinish?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension AddTransactionViewModel: FormValidatorDelegate {
    func wasSuccessed() {
        buttonCellViewModel.isEnabled = true
    }
    
    func wasFailed() {
        buttonCellViewModel.isEnabled = false
    }
}
