//
//  ReportViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 25.03.2021.
//

import UIKit

final class ReportViewModel {
    weak var view: ReportMoudleInput?
    
    private let firebaseStorage = FirebaseStorage.instance
    
    var selectedPeriod = Date.currentYearPeriod {
        didSet {
            loadReport()
        }
    }
    
    private let currentBalance: Double
    
    private var costTransactions: [FTransaction] = []
    private var incomeTransactions: [FTransaction] = []
    private var groupedTransactions: [String: [FTransaction]] = [:]
    private var dates: [String] = []
    private var costs = 0.0
    private var incomes = 0.0
        
    private var periodBalance: Double {
        incomes - costs
    }
    
    init(currentBalance: Double) {
        self.currentBalance = currentBalance
    }
    
    func loadReport() {
        costTransactions = []
        incomeTransactions = []
        groupedTransactions = [:]
        costs = 0
        incomes = 0
        dates = []
        
        loadTransactions()
    }
    
    private func headerTitle(for date: Date) -> String {
        guard Calendar.current.component(.year, from: Date()) == Calendar.current.component(.year, from: date) else {
            return DateFormatter.dayMonthFormatter.string(from: date)
        }
        return DateFormatter.dayMonthWordYearFormatter.string(from: date)
    }
    
    private func handleLoaded(transactions: [FTransaction]) {
        var incomes = 0.0
        var costs = 0.0
        defer {
            DispatchQueue.main.async { [weak view] in
                view?.fillTable()
            }
        }
        
        guard !transactions.isEmpty else {
            return
        }
        
        var sections = groupedTransactions
        var date = transactions.first!.date
        
        let titleDate = headerTitle(for: date)
        if !dates.contains(titleDate) {
            dates.append(headerTitle(for: date))
        }
        
        transactions.forEach {
            let dateString = headerTitle(for: $0.date)
            if !$0.date.isSameDay(for: date) {
                date = $0.date
                if !dates.contains(dateString) {
                    dates.append(dateString)
                }
            }
            var group = sections[dateString] ?? []
            group.append($0)
            sections[dateString] = group
            
            if $0.direction == .cost {
                costs += $0.amount
                costTransactions.append($0)
            }
            else {
                incomes += $0.amount
                incomeTransactions.append($0)
            }
        }
        
        self.costs = costs
        self.incomes = incomes
        groupedTransactions = sections
    }
    
    private func loadTransactions() {
        firebaseStorage.fetchTransactions(for: selectedPeriod) { [weak self] result in
            switch result {
            case .success(let res):
                self?.handleLoaded(transactions: res)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func openCostReport() {
        view?.onDetailderItemTap?((costTransactions, costs))
    }
    
    private func openIncomeReport() {
        view?.onDetailderItemTap?((incomeTransactions, incomes))
    }
}

extension ReportViewModel: ReportBuilderDataSource {
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
                    
                    return .init(transaction: transaction,showAccountName: true, cornerMask: cornerMask, tapAction: nil)
                }
            array.append((date, transactionViewModles))
        }
        
        return array
    }
    
    var reportCategoriesViewModels: [ReportCategoryCellViewModel] {
        [
            ReportCategoryCellViewModel(leftReportCategoryViewModel: .init(title: "Доходы",
                                                                           amount: incomes,
                                                                           tapAction: { [weak self] in
                                                                                self?.openIncomeReport()
                                                                           }),
                                        rightReportCategoryViewModel: .init(title: "Расходы",
                                                                            amount: costs,
                                                                            tapAction: { [weak self] in
                                                                                self?.openCostReport()
                                                                            })),
            ReportCategoryCellViewModel(leftReportCategoryViewModel: .init(title: "Баланс за период",
                                                                           amount: periodBalance),
                                        rightReportCategoryViewModel: .init(title: "Текущий баланс",
                                                                            amount: currentBalance))
        ]
    }
    
    var titleCellViewModel: TitleCellViewModel {
        if selectedPeriod == Date.currentWeekPeriod {
            return .init(title: "Все операции за текущую неделю")
        }
        else if selectedPeriod == Date.currentMonthPeriod {
            return .init(title: "Все операции за текущий меясц")
        }
        
        return .init(title: "Все операции за текущий год")
    }
    
}
