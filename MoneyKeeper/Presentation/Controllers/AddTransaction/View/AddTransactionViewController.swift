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
    var onCategoryTap: ParameterClosure<ParameterClosure<Category>>? { get set }
    var onAccountTap: ParameterClosure<ParameterClosure<Account>>? { get set }
}

final class AddTransactionViewController: BaseTableController<AddTransactionViewModel, AddTransactionBuilder>, AddTransactionModule {
    
    var onFinish: VoidClosure?
    var onCategoryTap: ParameterClosure<ParameterClosure<Category>>?
    var onAccountTap: ParameterClosure<ParameterClosure<Account>>? 

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
