//
//  CategoryReportBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation
import TableKit

protocol CategoryReportBuilderDataSource {
    var chartCellView: PieChartCellViewModel { get }
}

struct CategoryReportBuilder: BaseTableBuilder {
    
    func buildSections(from dataSource: CategoryReportBuilderDataSource) -> [TableSection] {
        [
            buildChartSection(from: dataSource)
        ]
    }
    
    private func buildChartSection(from dataSource: CategoryReportBuilderDataSource) -> TableSection {
        let row = TableRow<PieChartCell>(item: dataSource.chartCellView)
        
        return .init(onlyRows: [row])
    }
    
}
