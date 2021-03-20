//
//  Coordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation

protocol Coordinator: class {
    var finishFlow: ParameterClosure<Coordinator>? { get set }
    
    func start()
}
