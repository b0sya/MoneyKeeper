//
//  CategoriesListViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 18.04.2021.
//

import Foundation

final class CategoriesListViewModel {
    weak var view: CategoriesListModuleInput?
    
    private let direction: DirectionType
    private let firebaseStorage = FirebaseStorage.instance
    
    private var categories: [FCategory] = []
    private var mainCategory: FCategory?
    
    private var showSubcategoriesButton = true
    
    init(direction: DirectionType, showSubcategoriesButton: Bool) {
        self.direction = direction
        self.showSubcategoriesButton = showSubcategoriesButton
    }
    
    init(mainCategory: FCategory) {
        self.mainCategory = mainCategory
        self.direction = DirectionType(rawValue: mainCategory.directonId) ?? .cost
    }
    
    func loadCategories() {
        guard let mainCategory = mainCategory else {
            loadMainCategories()
            return
        }
        
        loadSubCategories(mainCategory: mainCategory)
    }
    
    private func loadSubCategories(mainCategory: FCategory) {
        firebaseStorage.fetchSubcategories(for: mainCategory) { [weak self] result in
            self?.handleLoadCategories(result: result)
        }
    }
    
    private func loadMainCategories() {
        firebaseStorage.fetchMainCategories(direction: direction) { [weak self] result in
            self?.handleLoadCategories(result: result)
        }
    }
    
    private func handleLoadCategories(result: FirebaseStorage.FetchCategoriesOutput) {
        switch result {
        case .success(let categories):
            self.categories = categories
            self.view?.fillTable()
        case .failure(let error):
            self.view?.showError(message: error.localizedDescription)
        }
    }
    
}

extension CategoriesListViewModel: CategoriesListBuilderDataSource {
    var ccategoryCellViewModel: [CategoryCellViewModel] {
        categories.compactMap { category in
            return .init(title: category.localizedName,
                         subcategoryCount: category.subcategoryIds.count,
                         showSubcategoriesButton: showSubcategoriesButton) { [weak self] in
                            self?.view?.onSubcategoriesTapped?(category)
                            
                         }
        }
    }
    
    func itemSelected(at index: Int) {
        guard index < categories.count else {
            return
        }
        
        view?.onCategorySelected?(categories[index])
    }
    
}
