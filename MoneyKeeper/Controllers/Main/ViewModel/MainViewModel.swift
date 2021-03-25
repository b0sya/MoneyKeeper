//
//  MainViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//

import Foundation
import CoreData

final class MainViewModel: MainBuilderDataSource {

    weak var view: MainViewController?

    private var accounts: [FAccount]?
    private let firebaseStorage = FirebaseStorage.instance

    func loadAccounts() {
        view?.showActivityIndicator()
        firebaseStorage.fetchAccounts { [weak self] result in
            self?.view?.hideActivityIndicator()
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
    
    var overalBalanceViewModel: AccountInfoCellViewModel? {
        guard let accounts = accounts else {
            return nil
        }
        
        let overalBalance = accounts.reduce(0) { (res, acc) in
            res + acc.balance
        }
        
        return .init(titleLabelText: .generalBalance, valueLabelText: NumberFormatter.rubFormatter.string(from: NSNumber(value: overalBalance)) ?? "")
    }
    
    var addAccountViewModel: TappableCellViewModel {
        .init { [weak self] in
            self?.view?.onAddAccount?()
        }
    }

    var accountsCellsViewModels: [AccountCellViewModel] {
        let viewModels = accounts?.map({ account in
            return AccountCellViewModel(title: account.name,
                                        value: account.balance,
                                        icon: nil) { [weak self] in
                self?.view?.onAccountTap?(account)
            }
        })

        return viewModels ?? []
    }
    

    var serviceCellsViewModel: [DefaultCellViewModel] {
        []
    }


}
