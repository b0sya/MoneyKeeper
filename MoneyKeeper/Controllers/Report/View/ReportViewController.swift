//
//  ReportViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 25.03.2021.
//

import Foundation
import TableKit

typealias ReportMoudleInput  = ReportModule & ReportInput

protocol ReportModule: Presentable {
    var onCostCategoryTap: ParameterClosure<[FTransaction]>? { get set }
}

protocol ReportInput: BaseContentInput {
    
}

final class ReportViewController: BaseTableController<ReportViewModel, ReportBuilder>, ReportMoudleInput {
    var onCostCategoryTap: ParameterClosure<[FTransaction]>?
    
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func refreshData() {
        super.refreshData()
        
        viewModel.loadReport()
    }
    
    override func localize() {
        super.localize()
        
        title = "Отчет"
    }
}
