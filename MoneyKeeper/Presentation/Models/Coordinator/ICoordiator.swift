//
//  ICoordiator.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//
import UIKit

protocol ICoordinator {
    var childCoordinators: [ICoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
