//
//  AddTransactionDataSource.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import TableKit

protocol AddTransactionBuilderDataSource {
    var transactionTypeViewModel: SegmentedControlCellViewModel { get }
    var amountCellViewModel: TextFieldCellViewModel { get }
    var descriptionCellViewModel: TextFieldCellViewModel { get }
    var categoryCellViewModel: SelectCellViewModel { get }
    
    var currencyCellViewModel: SegmentedControlCellViewModel { get }
    
    var accountCellViewModel: SelectCellViewModel { get }
    var dateCellViewModel: DatePickerCellViewModel { get }
    
    var buttonCellViewModel: ButtonCellViewModel { get }
    
}

struct AddTransactionBuilder: BaseTableBuilder {
	typealias DataSource = AddTransactionBuilderDataSource

    func buildSections(from dataSource: AddTransactionBuilderDataSource) -> [TableSection] {
        [
            buildTransactionTypeSection(from: dataSource),
            buildCurrencySection(from: dataSource),
            buildTransactionInfoSection(form: dataSource),
            buildTransactionDateSection(from: dataSource),
            buildButtonSection(from: dataSource),
        ]
    }
    
    private func buildTransactionTypeSection(from dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let row = TableRow<SegmentedControlCell>(item: dataSource.transactionTypeViewModel)
        return TableSection(onlyRows: [row])
    }

    private func buildCurrencySection(from dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let row = TableRow<TextFieldCell>(item: dataSource.amountCellViewModel)
        let currencyRow = TableRow<SegmentedControlCell>(item: dataSource.currencyCellViewModel)
        return TableSection(withEmptyHeader: [row, currencyRow])
    }

    private func buildTransactionInfoSection(form dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let descRow = TableRow<TextFieldCell>(item: dataSource.descriptionCellViewModel)
        let categoryRow = TableRow<SelectTextFieldCell>(item: dataSource.categoryCellViewModel).on(.click) { _ in
            dataSource.categoryCellViewModel.onTap?()
        }
        let accountRow = TableRow<SelectTextFieldCell>(item: dataSource.accountCellViewModel).on(.click) { _ in
            dataSource.accountCellViewModel.onTap?()
        }

        return .init(withEmptyHeader: [descRow, categoryRow, accountRow])
    }

    private func buildTransactionDateSection(from dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let row = TableRow<DatePickerCell>(item: dataSource.dateCellViewModel)

        return .init(withEmptyHeader: [row])
    }
    
    private func buildButtonSection(from dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let row = TableRow<ButtonCell>(item: dataSource.buttonCellViewModel)
        
        return .init(withEmptyHeader: [row])
    }
}
