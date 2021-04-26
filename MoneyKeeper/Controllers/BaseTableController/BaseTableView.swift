//
//  BaseTableView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import UIKit
import SnapKit

class BaseTableView: BaseView {
    let tableView = UITableView()

    override func addSubviews() {
        super.addSubviews()

        addSubview(tableView)
    }

    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag

        backgroundColor = .backgroundGray
    }
}
