//
//  Router.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation

protocol Router {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)

    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func popModule()
    func popModule(animated: Bool)

    func popToRootModule(animated: Bool)

    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
}
