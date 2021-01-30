//
//  MainCoordinator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//

import UIKit

final class MainCoordinator: ICoordinator {
    var childCoordinators = [ICoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        
    }
    
}
