//
//  BaseTableController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import Foundation
import TableKit

class BaseTableController<ViewModel, TableBuilder: BaseTableBuilder>: LoadableViewController<BaseTableView, ViewModel>, BaseContentInput {
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

        tableView.keyboardDismissMode = .interactive
    }
    

    func fillTable() {
        loadingIndicator.hide()
        tableDirector.clear()
        tableDirector.append(sections: buildSections())
        tableDirector.reload()
    }
    
    func refreshData() {
        loadingIndicator.show()
    }

}
