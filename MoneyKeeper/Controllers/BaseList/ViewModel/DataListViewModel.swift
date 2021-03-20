//
//  BaseListViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation

class BaseListViewModel: BaseListBilderDataSource {
    weak var view: BaseListViewController?
    
    ///override
    var cellViewModels: [TitleCellViewModel]? {
        fatalError("Override \"cellViewModels\" in subclasses")
    }
    
    ///override
    func itemSelected(for index: Int) {
        fatalError("Override \"itemSelected\" in subclasses")
    }
    
    ///override
    func loadData() {
        fatalError("Override \"loadData\" in subclasses")
    }
}
