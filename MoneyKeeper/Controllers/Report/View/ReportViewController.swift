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
    var onDetailderItemTap: ParameterClosure<(transactions: [FTransaction],
                                             totalValue: Double)>? { get set }
}

protocol ReportInput: BaseContentInput, LoadingPresentable {
    
}

final class ReportViewController: BaseTableController<ReportViewModel, ReportBuilder>, ReportMoudleInput {
    
    var onDetailderItemTap: ParameterClosure<(transactions: [FTransaction],
                                             totalValue: Double)>?
        
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func refreshData() {
        super.refreshData()
        viewModel.loadReport()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .calendarIcon, style: .plain, target: self, action: #selector(calendarButtonTapped))
    }
    
    @objc private func calendarButtonTapped() {
        let alert = UIAlertController(title: "Период", message: "Выберите период", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Неделя", style: .default, handler: { _ in
            self.viewModel.selectedPeriod = Date.currentWeekPeriod
        }))
        alert.addAction(UIAlertAction(title: "Месяц", style: .default, handler: { _ in
            self.viewModel.selectedPeriod = Date.currentMonthPeriod
        }))
        alert.addAction(UIAlertAction(title: "Год", style: .default, handler: { _ in
            self.viewModel.selectedPeriod = Date.currentYearPeriod
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func localize() {
        super.localize()
        
        title = "Отчет"
    }
}
