//
//  AddTransactionDataSource.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import TableKit

protocol AddTransactionBuilderDataSource {
    var currencyCellViewModel: TextFieldCellViewModel { get }
    var descriptionCellViewModel: TextFieldCellViewModel { get }
    var categoryCellViewModel: SelectCellViewModel { get }
    var dateCellViewModel: TextFieldCellViewModel { get }
    
}

struct AddTransactionBuilder {

    func buildSections(from dataSource: AddTransactionBuilderDataSource) -> [TableSection] {
        [
            buildCurrencySection(from: dataSource),
            buildTransactionInfoSection(form: dataSource),
            buildTransactionDateSection(from: dataSource)
        ]
    }

    private func buildCurrencySection(from dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let row = TableRow<TextFieldCell>(item: dataSource.currencyCellViewModel)
        return TableSection(onlyRows: [row])
    }

    private func buildTransactionInfoSection(form dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let descRow = TableRow<TextFieldCell>(item: dataSource.descriptionCellViewModel)
        let categoryRow = TableRow<SelectTextFieldCell>(item: dataSource.categoryCellViewModel)

        let section = TableSection(rows: [descRow, categoryRow])
        section.footerHeight = .leastNonzeroMagnitude
        section.headerView = UIView()
        section.headerHeight = 30

        return section
    }

    private func buildTransactionDateSection(from dataSource: AddTransactionBuilderDataSource) -> TableSection {
        let row = TableRow<DatePickerCell>(item: dataSource.dateCellViewModel)

        let section = TableSection(rows: [row])
        section.footerHeight = .leastNonzeroMagnitude
        section.headerView = UIView()
        section.headerHeight = 30

        return section
    }
}
