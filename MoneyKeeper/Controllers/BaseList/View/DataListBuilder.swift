//
//  BaseListBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import TableKit

protocol BaseListBilderDataSource {
    var cellViewModels: [TitleCellViewModel]? { get }
    
    func itemSelected(for index: Int)
}

struct BaseListBuilder: BaseTableBuilder {
    func buildSections(from dataSource: BaseListBilderDataSource) -> [TableSection] {
        [
            buildSection(from: dataSource)
        ]
    }
    
    private func buildSection(from dataSource: BaseListBilderDataSource) -> TableSection {
        let rows = dataSource.cellViewModels?
            .compactMap { item -> TableRow<TitleCell>? in
                TableRow<TitleCell>(item: item).on(TableRowAction<TitleCell>(.click, handler: { actionOption in
                    dataSource.itemSelected(for: actionOption.indexPath.row)
                }))
            }
        
        return .init(onlyRows: rows ?? [])
    }
}
