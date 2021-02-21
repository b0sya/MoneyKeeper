//
//  MainViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//

import Foundation
import CoreData

final class MainViewModel: RxViewModel, MainBuilderDataSource {

    weak var view: MainViewController?

    private var accounts: [Account]?

    func loadAccounts() {
        StorageProvider.shared.getAccounts { [weak self] result in
            switch result {
            case .success(let accounts):
                self?.accounts = accounts
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.view?.fillTable()
        }
    }
    
}

extension MainViewModel {
    var addAccountViewModel: TappableCellViewModel {
        .init { [weak self] in
            self?.view?.onAddAccount?()
        }
    }

    var accountsCellsViewModels: [AccountCellViewModel] {
        let viewModels = accounts?.map({
            return AccountCellViewModel(title: $0.name ?? "No name",
                                        value: $0.currency,
                                        icon: nil,
                                        tapAction: nil)
        })

        return viewModels ?? []
    }

    var serviceCellsViewModel: [DefaultCellViewModel] {
        []
    }


}
