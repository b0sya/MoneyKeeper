//
//  CategoriesListInputData.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 18.04.2021.
//

import Foundation

struct CategoriesListInputData {
    let direction: DirectionType
    let onCategorySelected: ParameterClosure<FCategory>
}
