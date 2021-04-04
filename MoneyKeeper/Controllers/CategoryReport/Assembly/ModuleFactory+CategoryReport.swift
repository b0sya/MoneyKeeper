//
//  ModuleFactory+CategoryReport.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation

protocol CategoryReportModuleFactory {
    func makeCategoryReportModule(for transactions: [FTransaction]) -> CategoryReportModule
}

extension ModuleFactoryImp: CategoryReportModuleFactory {
    func makeCategoryReportModule(for transactions: [FTransaction]) -> CategoryReportModule {
        let viewModel = CategoryReportViewModel(transactions: transactions)
        let controller = CategoryReportViewController(viewModel: viewModel)
        
        viewModel.view = controller
        return controller
    }
}
