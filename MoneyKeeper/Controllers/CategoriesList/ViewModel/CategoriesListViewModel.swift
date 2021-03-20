//
//  CategoriesListViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 07.03.2021.
//

import Foundation

final class CategoriesListViewModel: BaseListViewModel {
    private var categories: [FCategory] = []
    private let direction: DirectionType
    private let firebaseStorage = FirebaseStorage.instance
    
    init(direction: DirectionType) {
        self.direction = direction
    }
    
    override func loadData() {
        view?.showActivityIndicator()
        firebaseStorage.fetchCategories(direction: direction) { [weak self] result in
            self?.view?.hideActivityIndicator()
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
            return TitleCellViewModel(title: $0.localizedName)
        }
    }
    
    override func itemSelected(for index: Int) {
        guard index < categories.count else { return }
        
        view?.onItemSelected?(categories[index])
    }
    
    func addNewCategory(with name: String) {
        firebaseStorage.addCategory(name: name, direction: direction) { [weak self] result in
            switch result {
            case .success(_):
                self?.loadData()
            case .failure(let error):
                self?.view?.showError(message: error.localizedDescription)
            }
            
        }
    }
}

