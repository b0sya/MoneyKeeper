//
//  AddTransactionViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation
import TableKit

final class AddTransactionViewController: BaseTableController<AddTransactionViewModel> {
    private let builder = AddTransactionBuilder()

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func refreshData() {
        super.refreshData()

        fillTable()
    }

    override func configureAppearance() {
        title = .addransactionScreenTitle
    }
}
