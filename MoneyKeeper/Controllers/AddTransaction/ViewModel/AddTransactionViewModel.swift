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
    private let transactionTypeTitles: [String] = [.expense, .income]
    private let currencies: [String] = Currency.stringArray
    private let firebaseStorage = FirebaseStorage.instance
    private let currencyService = CurrencyConverterService()
    
    let amountCellViewModel: TextFieldCellViewModel = .value()
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
    let currencyCellViewModel: SegmentedControlCellViewModel
    
    init() {
        transactionTypeViewModel = .init(segmentTitles: transactionTypeTitles, selectedIndex: Int(validator.direction?.rawValue ?? 0))
        
        currencyCellViewModel = .init(segmentTitles: currencies, selectedIndex: 0)
        
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
        amountCellViewModel.onTextFieldEdited = { [weak validator] string in
            validator?.amount = Double(string ?? "")
        }
        
        currencyCellViewModel.onChangedSegmentedIndex = { [weak self] in
            guard let self = self else { return }
            self.validator.currency = Currency(rawValue: self.currencies[$0])
        }
        
        descriptionCellViewModel.onTextFieldEdited = { [weak validator] string in
            validator?.description = string
        }
        
        categoryCellViewModel.onTap = { [ weak self] in
            guard let direction = self?.validator.direction else { return }

            let input = CategoriesListInputData(direction: direction) { [weak self] in
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
            self?.doneButtonTapped()
            
        }
    }
    
    private func doneButtonTapped() {
        guard var data = validator.cleanData else {
            return
        }
        
        if data.currency != .RUB {
            view?.showActivityIndicator()
            currencyService.exchangeRateToRubFor(currency: data.currency) { [weak self] (res) in
                self?.view?.hideActivityIndicator()
                switch res {
                case .success(let responce):
                    data.mainAmount *= responce.conversion_rates.RUB ?? 1
                    self?.saveTransaction(data: data)
                case .failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
        else {
            saveTransaction(data: data)
        }
    }
    
    private func saveTransaction(data: AddTransactionFormData) {
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
