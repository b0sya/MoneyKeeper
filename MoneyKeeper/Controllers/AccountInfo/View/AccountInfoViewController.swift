//
//  AccountInfoViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import TableKit

protocol AccountInfoModule: Presentable {
    func fillTable()
}

final class AccountInfoViewController: BaseTableController<AccountInfoViewModel, AccountInfoBuilder>, AccountInfoModule {
    
    override func localize() {
        super.localize()
        
        title = viewModel.screenTitle
    }
    
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func refreshData() {
        super.refreshData()
        
        viewModel.loadTransactions()
    }
}
