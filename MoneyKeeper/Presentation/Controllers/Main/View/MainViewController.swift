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
    var onAddTransaction: VoidClosure? { get set }

    func refreshData()
}

final class MainViewController: BaseTableController<MainViewModel>, MainModule {
    private let builder = MainBuilder()

    var onAddAccount: VoidClosure?
    var onAddTransaction: VoidClosure?

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func refreshData() {
        viewModel.loadAccounts()
    }

    override func configureAppearance() {
        super.configureAppearance()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTransactionTapped))
    }

    override func localize() {
        super.localize()

        title = .mainScreenTitle
    }

    @objc private func addTransactionTapped() {
        onAddTransaction?()
    }
}
