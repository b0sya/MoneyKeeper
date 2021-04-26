//
//  CategoriesListBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 18.04.2021.
//

import Foundation
import TableKit

protocol CategoriesListBuilderDataSource {
    var ccategoryCellViewModel: [CategoryCellViewModel] { get }
    
    func itemSelected(at index: Int)
}

struct CategoriesListBuilder: BaseTableBuilder {
    typealias CategoryCell = DefaultCellContainer<CategoryCellView>
    
    func buildSections(from dataSource: CategoriesListBuilderDataSource) -> [TableSection] {
        [
            buildSection(from: dataSource)
        ]
    }
    
    private func buildSection(from dataSource: CategoriesListBuilderDataSource) -> TableSection {
        let rows = dataSource.ccategoryCellViewModel.map { item in
            TableRow<CategoryCell>(item: item).on(.click) { options in
                dataSource.itemSelected(at: options.indexPath.row)
            }
        }
        
        return .init(onlyRows: rows)
    }
}
