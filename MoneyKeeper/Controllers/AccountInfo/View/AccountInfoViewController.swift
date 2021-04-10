//
//  AccountInfoViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import TableKit

typealias AccountInfoModuleInput  = AccountInfoModule & AccountInfoInput

protocol AccountInfoModule: Presentable {
    var onFinishDelete: VoidClosure? { get set }
}

protocol AccountInfoInput: ErrorPresentable, LoadingPresentable, BaseContentInput {
    
}

final class AccountInfoViewController: BaseTableController<AccountInfoViewModel, AccountInfoBuilder>, AccountInfoModuleInput {
    
    var onFinishDelete: VoidClosure?
    
    
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
    
    override func configureAppearance() {
        super.configureAppearance()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                            target: self,
                                                            action: #selector(removeButtonTapped))
    }
    
    @objc private func removeButtonTapped() {
        viewModel.removeAccount()
    }
}
