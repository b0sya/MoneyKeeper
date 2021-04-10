//
//  ErrorPresentable.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 10.04.2021.
//

import Foundation

protocol ErrorPresentable: class {
    func showError(message: String)
}
