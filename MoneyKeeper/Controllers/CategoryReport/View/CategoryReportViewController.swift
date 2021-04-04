//
//  CategoryReportViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation
import TableKit

typealias CategoryReportModuleInput = CategoryReportModule & CategoryReportInput

protocol CategoryReportModule: Presentable {
    
}

protocol CategoryReportInput: BaseContentInput {
    
}

final class CategoryReportViewController: BaseTableController<CategoryReportViewModel, CategoryReportBuilder>, CategoryReportModuleInput {
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func refreshData() {
        super.refreshData()
        
        fillTable()
    }
    
    override func configureAppearance() {
        title = "Отчет по категориям"
    }
}
