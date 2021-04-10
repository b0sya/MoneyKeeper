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
    var onItemSelected: ParameterClosure<FirestoreModel>? { get set }
    var onAddTapped: VoidClosure? { get set }
    
    func refreshData()
}

class BaseListViewController: BaseTableController<BaseListViewModel, BaseListBuilder>, BaseListModule {
    var onItemSelected: ParameterClosure<FirestoreModel>?
    var onAddTapped: VoidClosure? {
        didSet {
            configureAddButton()
        }
    }
    
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func refreshData() {
        super.refreshData()
        
        viewModel.loadData()
    }
    
    override func localize() {
        title = .categories
    }
    
    private func configureAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTapped))
    }
    
    @objc private func onAddButtonTapped() {
        onAddTapped?()
    }
    
}
