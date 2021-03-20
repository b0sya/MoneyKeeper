//
//  ModuleFactory+AccountInfo.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import Foundation

protocol AccountInfoModuleFactory {
    func makeAccountInfoModule(account: FAccount) -> AccountInfoModule
}

extension ModuleFactoryImp: AccountInfoModuleFactory {
    func makeAccountInfoModule(account: FAccount) -> AccountInfoModule {
        let viewModel = AccountInfoViewModel(account: account)
        let vc = AccountInfoViewController(viewModel: viewModel)
        viewModel.view = vc
        
        return vc
    }
}
