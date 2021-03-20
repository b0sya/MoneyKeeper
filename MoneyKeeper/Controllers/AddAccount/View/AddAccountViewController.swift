//
//  AddAccountViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 03.02.2021.
//

import Foundation
import TableKit
import os.log

protocol AddAccountModule: Presentable {
    var onFinish: VoidClosure? { get set }
}

final class AddAccountViewController: BaseTableController<AddAccountViewModel, AddAccountBuilder>, AddAccountModule {

    private var accountName: String?
    private var accountBalance: Double?

    var onFinish: VoidClosure?

    //MARK: - Overrode

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func refreshData() {
        super.refreshData()

        fillTable()
    }

    override func localize() {
        title = .newAccount
    }
}
