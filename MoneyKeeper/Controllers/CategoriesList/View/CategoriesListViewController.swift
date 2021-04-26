//
//  CategoriesListViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 18.04.2021.
//

import Foundation
import TableKit

typealias CategoriesListModuleInput = CategoriesListModule & CategoriesListInput

protocol CategoriesListModule: Presentable {
    var onCategorySelected: ParameterClosure<FCategory>? { get set }
    var onSubcategoriesTapped: ParameterClosure<FCategory>? { get set }
}

protocol CategoriesListInput: ErrorPresentable, LoadingPresentable, BaseContentInput {
    
}

final class CategoriesListViewController: BaseTableController<CategoriesListViewModel, CategoriesListBuilder>, CategoriesListModuleInput {
    var onSubcategoriesTapped: ParameterClosure<FCategory>?
    var onCategorySelected: ParameterClosure<FCategory>?
    
    override func refreshData() {
        super.refreshData()
        
        viewModel.loadCategories()
    }
    
    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }
    
    override func localize() {
        super.localize()
        
        title = "Категории"
    }
}
