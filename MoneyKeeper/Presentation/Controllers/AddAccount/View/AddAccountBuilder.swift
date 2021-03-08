//
//  AddAccountBuilder.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 03.02.2021.
//

import TableKit

protocol AddAccountBuilderDataSource {
    var textFieldViewModels: [TextFieldCellViewModel] { get }
    var buttonCellViewModel: ButtonCellViewModel { get }
}

struct AddAccountBuilder: BaseTableBuilder {

    func buildSections(from dataSource: AddAccountBuilderDataSource) -> [TableSection] {
        [
            buildFormSection(from: dataSource),
            buildButtonSection(from: dataSource)
        ]
    }

    private func buildFormSection(from dataSource: AddAccountBuilderDataSource) -> TableSection {
        let rows: [Row] = dataSource.textFieldViewModels
            .compactMap { item -> TableRow<TextFieldCell>? in
                TableRow<TextFieldCell>(item: item)
        }

        return .init(onlyRows: rows)
    }

    private func buildButtonSection(from dataSource: AddAccountBuilderDataSource) -> TableSection {
        let row = TableRow<ButtonCell>(item: dataSource.buttonCellViewModel)

        return .init(withEmptyHeader: [row])
    }
}
