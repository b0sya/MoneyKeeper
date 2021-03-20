//
//  CategoryListInput.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 08.03.2021.
//

import Foundation

struct CategoryListInput {
    let direction: DirectionType
    let completion: ParameterClosure<FCategory>
}
