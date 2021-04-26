//
//  CategoryCellViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 15.04.2021.
//

import Foundation

struct CategoryCellViewModel {
    let title: String
    let subcategoryCountText: String?
    let showSubcategoriesButton: Bool
    let onGoTuSubcategoriesTap: VoidClosure?
    
    init(title: String, subcategoryCount: Int, showSubcategoriesButton: Bool = true, onGoToSubcategoriesTap: VoidClosure?) {
        self.title = title
        self.showSubcategoriesButton = showSubcategoriesButton
        if subcategoryCount != 0 {
            self.subcategoryCountText = "Подкатегорий: \(subcategoryCount)"
        }
        else {
            self.subcategoryCountText = nil
        }
        
        self.onGoTuSubcategoriesTap = onGoToSubcategoriesTap
    }
}
