//
//  ModuleFactory+CategoryReport.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation

protocol DetailedReportModuleFactory {
    func makeDetailedReportModule(for transactions: [FTransaction], totalValue: Double) -> DetailedReportModule
}

extension ModuleFactoryImp: DetailedReportModuleFactory {
    func makeDetailedReportModule(for transactions: [FTransaction], totalValue: Double) -> DetailedReportModule {
        let viewModel = DetailedReportViewModel(transactions: transactions, totalValue: totalValue)
        let controller = DetailedReportViewController(viewModel: viewModel)
        
        viewModel.view = controller
        return controller
    }
}
