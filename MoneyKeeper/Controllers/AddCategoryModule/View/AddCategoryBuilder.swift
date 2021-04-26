//
//  AddCategoryBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 17.04.2021.
//

import Foundation
import TableKit

protocol AddCategoryBuilderDataSource {
    var nameCellViewModel: TextFieldCellViewModel { get }
    var parentCategorySelectViewModel: SelectCellViewModel { get }
    var directionsViewModel: SegmentedControlCellViewModel { get }
    
    var doneButtonViewModel: ButtonCellViewModel { get }
}

struct AddCategoryBuilder: BaseTableBuilder {
    func buildSections(from dataSource: AddCategoryBuilderDataSource) -> [TableSection] {
        [
            buildFormSection(from: dataSource),
            buildButtonSection(from: dataSource)
        ]
    }
    
    private func buildFormSection(from dataSource: AddCategoryBuilderDataSource) -> TableSection {
        let nameRow = TableRow<TextFieldCell>(item: dataSource.nameCellViewModel)
        let parentRow = TableRow<SelectTextFieldCell>(item: dataSource.parentCategorySelectViewModel)
        let directionRow = TableRow<SegmentedControlCell>(item: dataSource.directionsViewModel)
        
        return .init(onlyRows: [directionRow, nameRow, parentRow])
    }
    
    private func buildButtonSection(from dataSource: AddCategoryBuilderDataSource) -> TableSection {
        let row = TableRow<ButtonCell>(item: dataSource.doneButtonViewModel)
        
        return .init(withEmptyHeader: [row])
    }
    
}
