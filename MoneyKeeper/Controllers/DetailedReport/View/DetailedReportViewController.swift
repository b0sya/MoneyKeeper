//
//  DetailedReportViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation
import TableKit

typealias DetailedReportModuleInput = DetailedReportModule & DetailedReportInput

protocol DetailedReportModule: Presentable {
    
}

protocol DetailedReportInput: BaseContentInput {
    
}

final class DetailedReportViewController: BaseTableController<DetailedReportViewModel, DetailedReportBuilder>, DetailedReportModuleInput {
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
