//
//  BaseListViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import UIKit
import TableKit
import CoreData

protocol BaseListModule: Presentable {
    var onItemSelected: ParameterClosure<NSManagedObject>? { get set }
}

class BaseListViewController: BaseTableController<BaseListViewModel, BaseListBuilder>, BaseListModule {
    var onItemSelected: ParameterClosure<NSManagedObject>?
    
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func refreshData() {
        viewModel.loadData()
    }
    
    override func localize() {
        title = .categories
    }
    
    
}
