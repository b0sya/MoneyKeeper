//
//  ReportViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 25.03.2021.
//

import Foundation

final class ReportViewModel {
    weak var view: ReportMoudleInput?
    
    private let firebaseStorage = FirebaseStorage.instance
    private let selectedPeriod = Date.currentYearPeriod
    
    private var transactions: [FTransaction] = []
    private var costs = 0.0
    private var incomes = 0.0
    private var currentBalance = 0.0
    
    private var periodBalance: Double {
        incomes - costs
    }
    
    func loadReport() {
        let group = DispatchGroup()
        group.enter()
        firebaseStorage.fetchTransactions(for: selectedPeriod) { [weak self] result in
            switch result {
            case .success(let res):
                group.leave()
                self?.transactions = res
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.enter()
        firebaseStorage.fetchAccounts { [weak self] result in
            switch result {
            case .success(let accounts):
                group.leave()
                self?.currentBalance = accounts.reduce(0.0, { res, acc in
                    res + acc.balance
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .global(qos: .userInitiated)) {
            self.createReport()
        }
    }
    
    private func createReport() {
        var incomes = 0.0
        var costs = 0.0
        
        transactions.forEach {
            if $0.direction == .cost {
                costs += $0.amount
            }
            else {
                incomes += $0.amount
            }
        }
        
        self.costs = costs
        self.incomes = incomes
        
        DispatchQueue.main.async { [weak view] in
            view?.fillTable()
        }
    }
}

extension ReportViewModel: ReportBuilderDataSource {
    var reportCategoriesViewModels: [ReportCategoryCellViewModel] {
        [
            ReportCategoryCellViewModel(leftReportCategoryViewModel: .init(title: "Доходы",
                                                                           amount: incomes),
                                        rightReportCategoryViewModel: .init(title: "Расходы",
                                                                            amount: costs,
                                                                            tapAction: { [weak self] in
                                                                                guard let transactions = self?.transactions else { return }
                                                                                self?.view?.onCostCategoryTap?(transactions)
                                                                            })),
            ReportCategoryCellViewModel(leftReportCategoryViewModel: .init(title: "Баланс за период",
                                                                           amount: periodBalance),
                                        rightReportCategoryViewModel: .init(title: "Текущий баланс",
                                                                            amount: currentBalance))
        ]
    }
    
    var titleCellViewModel: TitleCellViewModel {
        .init(title: "Все перации за выбранный период")
    }
    
}
