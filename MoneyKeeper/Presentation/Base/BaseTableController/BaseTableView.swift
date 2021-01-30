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
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(snp.topMargin)
            $0.bottom.equalTo(snp.bottomMargin)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        tableView.separatorStyle = .none
    }
}
