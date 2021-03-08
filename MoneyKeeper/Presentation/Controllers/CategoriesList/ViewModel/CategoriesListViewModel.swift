//
//  CategoriesListViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 07.03.2021.
//

import Foundation

final class CategoriesListViewModel: BaseListViewModel {
    private var categories: [Category] = []
    
    override func loadData() {
        StorageProvider.shared.getCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.view?.fillTable()
            case .failure(let error):
                self?.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    override var cellViewModels: [TitleCellViewModel]? {
        return categories.map {
            return TitleCellViewModel(title: $0.name ?? "no name")
        }
    }
    
    override func itemSelected(for index: Int) {
        guard index < categories.count else { return }
        
        view?.onItemSelected?(categories[index])
    }
}

