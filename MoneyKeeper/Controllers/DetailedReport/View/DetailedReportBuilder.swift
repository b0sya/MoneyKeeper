//
//  DetailedReportBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation
import TableKit

protocol DetailedReportBuilderDataSource {
    var chartCellView: PieChartCellViewModel { get }
    
    var categoriesCellsViewModels: [AccountCellViewModel] { get }
}

struct DetailedReportBuilder: BaseTableBuilder {
    
    typealias CategoryCell = DefaultCellContainer<AccountCellView>
    
    func buildSections(from dataSource: DetailedReportBuilderDataSource) -> [TableSection] {
        [
            buildChartSection(from: dataSource),
            buildCategoriesSection(from: dataSource)
        ]
    }
    
    private func buildChartSection(from dataSource: DetailedReportBuilderDataSource) -> TableSection {
        let row = TableRow<PieChartCell>(item: dataSource.chartCellView)
        
        return .init(onlyRows: [row])
    }
    
    private func buildCategoriesSection(from dataSource: DetailedReportBuilderDataSource) -> TableSection {
        let rows: [Row] = dataSource.categoriesCellsViewModels
            .compactMap {
                TableRow<CategoryCell>(item: $0)
            }
        
        return .init(onlyRows: rows)
    }
    
}
