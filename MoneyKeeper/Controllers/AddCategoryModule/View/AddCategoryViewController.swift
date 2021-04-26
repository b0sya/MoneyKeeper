//
//  AddCategoryViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 17.04.2021.
//

import Foundation
import TableKit

typealias AddCategoryModuleInput = AddCategoryModule & AddCategoryInput

protocol AddCategoryModule: Presentable {
    var onParentCategoryTap: ParameterClosure<CategoriesListInputData>? { get set }
    var onFinish: VoidClosure? { get set }
}

protocol AddCategoryInput: ErrorPresentable, LoadingPresentable {
    
}

final class AddCategoryViewController: BaseTableController<AddCategoryViewModel, AddCategoryBuilder>, AddCategoryModuleInput {
    var onParentCategoryTap: ParameterClosure<CategoriesListInputData>?
    var onFinish: VoidClosure?
    
    override func refreshData() {
        super.refreshData()
        
        fillTable()
    }
    
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func localize() {
        super.localize()
        
        title = .newCategory
    }
}
