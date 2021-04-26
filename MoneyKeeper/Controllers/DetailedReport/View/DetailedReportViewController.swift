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
    var onShowSubcategories: ParameterClosure<(transactions: [FTransaction], categories: [String: FCategory], totalValue: Double)>? { get set }
}

protocol DetailedReportInput: BaseContentInput {
    
}

final class DetailedReportViewController: BaseTableController<DetailedReportViewModel, DetailedReportBuilder>, DetailedReportModuleInput {
    var onShowSubcategories: ParameterClosure<(transactions: [FTransaction], categories: [String: FCategory], totalValue: Double)>?
    
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func refreshData() {
        super.refreshData()
        
        viewModel.loadCateegories()
    }
    
    override func configureAppearance() {
        title = "Отчет по категориям"
    }
}
