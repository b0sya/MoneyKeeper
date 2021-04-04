//
//  MainViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import Foundation
import TableKit

protocol MainModule: Presentable {
    var onAddAccount: VoidClosure? { get set }
    var onAccountTap: ParameterClosure<FAccount>? { get set }
    var onAddTransaction: VoidClosure? { get set }
    var onReportTapped: VoidClosure? { get set }

    func refreshData()
}

final class MainViewController: BaseTableController<MainViewModel, MainBuilder>, MainModule {
	
    var onAddAccount: VoidClosure?
    var onAccountTap: ParameterClosure<FAccount>?
    var onAddTransaction: VoidClosure?
    var onReportTapped: VoidClosure?

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func refreshData() {
        viewModel.loadAccounts()
    }

    override func configureAppearance() {
        super.configureAppearance()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTransactionTapped))
    }

    override func localize() {
        super.localize()

        title = .accounts
    }

    @objc private func addTransactionTapped() {
        onAddTransaction?()
    }
}
