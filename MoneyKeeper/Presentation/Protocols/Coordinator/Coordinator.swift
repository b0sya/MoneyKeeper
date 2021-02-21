//
//  Coordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation

protocol Coordinator: class {
    func start()
}

protocol CoordinatorOutput {
    associatedtype Item
    
    var finishFlow: ((Item) -> Void)? { get set }
}
