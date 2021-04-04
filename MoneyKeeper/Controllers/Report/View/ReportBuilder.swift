//
//  ReportBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 25.03.2021.
//

import Foundation
import TableKit

protocol ReportBuilderDataSource {
    var reportCategoriesViewModels: [ReportCategoryCellViewModel] { get }
    var titleCellViewModel: TitleCellViewModel { get }
}

struct ReportBuilder: BaseTableBuilder {
    typealias CategoriesRow = DefaultCellContainer<ReportCategoriesCellView>
    
    func buildSections(from dataSource: ReportBuilderDataSource) -> [TableSection] {
        [
            buildCategoriesSection(from: dataSource),
            buildTitleSection(from: dataSource)
        ]
    }
    
    private func buildCategoriesSection(from dataSource: ReportBuilderDataSource) -> TableSection {
        let rows = dataSource.reportCategoriesViewModels.map {
            TableRow<CategoriesRow>(item: $0)
        }
        
        return .init(onlyRows: rows)
    }
    
    private func buildTitleSection(from dataSource: ReportBuilderDataSource) -> TableSection {
        let row = TableRow<TitleCell>(item: dataSource.titleCellViewModel)
        return .init(onlyRows: [row])
    }
}
