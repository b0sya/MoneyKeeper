//
//  BaseTableController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import Foundation
import TableKit

class BaseTableController<ViewModel, TableBuilder: BaseTableBuilder>: BaseViewController<BaseTableView, ViewModel>, BaseContentInput {
    private(set) lazy var tableDirector = TableDirector(tableView: baseView.tableView)
	
	let builder = TableBuilder()

    var tableView: UITableView {
        baseView.tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshData()
    }

    func buildSections() -> [TableSection] {
        []
    }

    override func configureAppearance() {
        super.configureAppearance()

		tableView.keyboardDismissMode = .onDrag
        tableView.contentInset.bottom = 100
    }
    

    func fillTable() {
        tableDirector.clear()
        tableDirector.append(sections: buildSections())
        tableDirector.reload()
    }
    
    func refreshData() {}

}
