//
//  CategoriesListViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 07.03.2021.
//

import UIKit

protocol CategoriesListModule: BaseListModule {
    func addCategory(with name: String)
}

final class CategoriesListViewController: BaseListViewController, CategoriesListModule {
    

    override func localize() {
        title = .categories
    }

    func addCategory(with name: String) {
        guard let viewModel = viewModel as? CategoriesListViewModel else {
            return
        }
        
        viewModel.addNewCategory(with: name)
    }
}
