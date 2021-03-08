//
//  AccountListViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 07.03.2021.
//

import Foundation

final class AccountsListViewModel: BaseListViewModel {
    private var accounts: [Account] = []
    
    override func loadData() {
        StorageProvider.shared.getAccounts { [weak self] result in
            switch result {
            case .success(let accounts):
                self?.accounts = accounts
                self?.view?.fillTable()
            case .failure(let error):
                self?.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    override var cellViewModels: [TitleCellViewModel]? {
        return accounts.map {
            return TitleCellViewModel(title: $0.name ?? "no name")
        }
    }
    
    override func itemSelected(for index: Int) {
        guard index < accounts.count else { return }
        
        view?.onItemSelected?(accounts[index])
    }
}
