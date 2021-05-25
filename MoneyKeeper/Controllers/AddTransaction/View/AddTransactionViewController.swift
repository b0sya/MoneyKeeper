//
//  AddTransactionViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation
import TableKit
import os.log

protocol AddTransactionModule: Presentable {
    var onFinish: VoidClosure? { get set }
    var onCategoryTap: ParameterClosure<CategoriesListInputData>? { get set }
    var onAccountTap: ParameterClosure<ParameterClosure<FAccount>>? { get set }
}

final class AddTransactionViewController: BaseTableController<AddTransactionViewModel, AddTransactionBuilder>, AddTransactionModule, ErrorPresentable {
    var onCategoryTap: ParameterClosure<CategoriesListInputData>?
    var onFinish: VoidClosure?
    var onAccountTap: ParameterClosure<ParameterClosure<FAccount>>?

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func refreshData() {
        super.refreshData()

        fillTable()
    }

    override func configureAppearance() {
        title = .newTransaction
    }
}
