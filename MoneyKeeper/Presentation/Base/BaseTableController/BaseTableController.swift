//
//  BaseTableController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import Foundation
import TableKit

class BaseTableController<ViewModel>: BaseViewController<BaseTableView, ViewModel>, BaseContentInput {
    private(set) lazy var tableDirector = TableDirector(tableView: baseView.tableView)

    var tableView: UITableView {
        baseView.tableView
    }

    func buildSections() -> [TableSection] {
        []
    }

    func configureTable() {
        
    }
    
    func refreshData() {}

}
