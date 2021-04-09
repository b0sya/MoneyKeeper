//
//  ModuleFactory+ReportModule.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 25.03.2021.
//

import Foundation

protocol ReportModuleFactory {
    func makeReportModule(currentBalance: Double) -> ReportModule
}

extension ModuleFactoryImp: ReportModuleFactory {
    func makeReportModule(currentBalance: Double) -> ReportModule {
        let viewModel = ReportViewModel(currentBalance: currentBalance)
        let viewController = ReportViewController(viewModel: viewModel)
        
        viewModel.view = viewController
        return viewController
    }
}

