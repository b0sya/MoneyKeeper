//
//  BaseCoordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var finishFlow: ParameterClosure<Coordinator>?
    
    func start() {}

    func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func bind<C: Coordinator>(_ coordinator: C, completion: VoidClosure? = nil) {
        coordinator.finishFlow = { [weak self] in
            completion?()
            self?.removeDependency($0)
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
    
    func onFinishSelf() {
        finishFlow?(self)
    }
    
}
