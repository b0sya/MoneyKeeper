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
    
    let currencyCellViewModel: TextFieldCellViewModel = .value()
    let descriptionCellViewModel: TextFieldCellViewModel = .description()
    let categoryCellViewModel: SelectCellViewModel = .init(title: .category,
                                                           value: nil,
                                                           isRequired: true)
    let accountCellViewModel: SelectCellViewModel = .init(title: .account,
                                                           value: nil,
                                                           isRequired: true)
    let dateCellViewModel: TextFieldCellViewModel
    
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
            self?.view?.onCategoryTap? { [weak self] in
                self?.validator.category = $0
                self?.categoryCellViewModel.value = $0.name
            }
        }
        
        accountCellViewModel.onTap = { [ weak self] in
            self?.view?.onAccountTap? { [weak self] in
                self?.validator.account = $0
                self?.accountCellViewModel.value = $0.name
            }
        }
        
        dateCellViewModel.onTextFieldEdited = { [weak validator] string in
            //FIXME: FORCE UNWRAP
            validator?.date = DateFormatter.dayMonthWordYearTimeFormatter.date(from: string ?? "")!
        }
        
        buttonCellViewModel.buttonAction = { [weak validator] in
            validator?.save { [weak self] result in
                switch result {
                case .success(_):
                    self?.view?.onFinish?()
                case .failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
                }
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
