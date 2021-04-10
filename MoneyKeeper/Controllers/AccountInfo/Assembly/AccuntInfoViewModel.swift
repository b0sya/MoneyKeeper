//
//  AccuntInfoViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class AccountInfoViewModel {
    weak var view: AccountInfoModuleInput?
    
    private var transactions: [FTransaction] = [] {
        didSet {
            updateViewModels()
        }
    }
    
    private var groupedTransactions: [String: [FTransaction]] = [:]
    
    private var dates: [String] = []
    
    private let account: FAccount
    private let firebaseStorage = FirebaseStorage.instance
    
    var screenTitle: String {
        account.name
    }
    
    init(account: FAccount) {
        self.account = account
    }
    
    func loadTransactions() {
        firebaseStorage.fetchTransactions(for: account) { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.transactions = transactions.sorted {$0.date > $1.date}
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.view?.fillTable()
        }
    }
    
    private func headerTitle(for date: Date) -> String {
        guard Calendar.current.component(.year, from: Date()) == Calendar.current.component(.year, from: date) else {
            return DateFormatter.dayMonthFormatter.string(from: date)
        }
        return DateFormatter.dayMonthWordYearFormatter.string(from: date)
    }
    
    private func updateViewModels() {
        guard !transactions.isEmpty else { return }
        
        var sections = groupedTransactions
        var date = transactions.first!.date
        
        let titleDate = headerTitle(for: date)
        if !dates.contains(titleDate) {
            dates.append(headerTitle(for: date))
        }
        
        for transaction in transactions {
            let dateString = headerTitle(for: transaction.date)
            if !transaction.date.isSameDay(for: date) {
                date = transaction.date
                if !dates.contains(dateString) {
                    dates.append(dateString)
                }
            }
            var group = sections[dateString] ?? []
            group.append(transaction)
            sections[dateString] = group
        }
        
        groupedTransactions = sections
    }
    
    func removeAccount() {
        view?.showActivityIndicator()
        firebaseStorage.remove(account: account, transactions: transactions) { [weak view] result in
            view?.hideActivityIndicator()
            switch result {
            case .failure(let error):
                view?.showError(message: error.localizedDescription)
            case .success(_):
                view?.onFinishDelete?()
            }
        }
    }
}

extension AccountInfoViewModel: AccountInfoBuilderInput {
    var accountInfoCellViewModel: AccountInfoCellViewModel {
        guard let balance = NumberFormatter.rub.string(from: NSNumber(value: account.balance)) else  {
            return .init(titleLabelText: .currentBalance, valueLabelText: "!ERROR!")

        }
        return .init(titleLabelText: .currentBalance, valueLabelText: balance)
    }
    
    var transactionCellViewModels: [(String, [TransactionCellViewModel])]? {
        guard !groupedTransactions.isEmpty else {
            return nil
        }
        
        var array: [(String, [TransactionCellViewModel])] = []
        
        for date in dates {
            let transactionsForDate = groupedTransactions[date] ?? []
            let transactionViewModles = transactionsForDate
                .enumerated()
                .compactMap { (index: Int, transaction: FTransaction) -> TransactionCellViewModel? in
                    var cornerMask: CACornerMask?
                    let isFirst = index == 0
                    let isLast = index == transactionsForDate.count - 1
                    let isSingle = transactionsForDate.count - 1 == 0
                    
                    if isSingle {
                        cornerMask = .allCorners
                    } else if isFirst {
                        cornerMask = .topCorners
                    } else if isLast {
                        cornerMask = .bottomCorners
                    }
                    
                    return .init(transaction: transaction, cornerMask: cornerMask, tapAction: nil)
                }
            array.append((date, transactionViewModles))
        }
        
        return array
    }
}
