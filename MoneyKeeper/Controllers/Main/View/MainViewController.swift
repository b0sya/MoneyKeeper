//
//  MainViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import Foundation
import TableKit

typealias MainModuleInput = MainModule & MainInput

protocol MainModule: Presentable {
    var currentBalance: Double { get }
    
    var onAddAccount: VoidClosure? { get set }
    var onAccountTap: ParameterClosure<FAccount>? { get set }
    var onAddTransaction: VoidClosure? { get set }
    var onSettingsTapped: VoidClosure? { get set }
    var onReportTapped: VoidClosure? { get set }
    var onAddCategoryTapped: VoidClosure? { get set }

    func refreshData()
}

protocol MainInput: LoadingPresentable, BaseContentInput {
    
}

final class MainViewController: BaseTableController<MainViewModel, MainBuilder>, MainModuleInput {
    
    var currentBalance: Double {
        viewModel.currentBalance
    }
	
    var onAddAccount: VoidClosure?
    var onAccountTap: ParameterClosure<FAccount>?
    var onAddTransaction: VoidClosure?
    var onSettingsTapped: VoidClosure?
    var onReportTapped: VoidClosure?
    var onAddCategoryTapped: VoidClosure?

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func refreshData() {
        super.refreshData()
        
        viewModel.loadAccounts()
    }

    override func configureAppearance() {
        super.configureAppearance()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTransactionTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .settings,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(settingsButtonTapped))
    }

    override func localize() {
        super.localize()

        title = .accounts
    }

    @objc private func addTransactionTapped() {
        onAddTransaction?()
    }
    
    @objc private func settingsButtonTapped() {
        onSettingsTapped?()
    }
}
