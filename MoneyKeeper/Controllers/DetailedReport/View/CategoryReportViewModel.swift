//
//  CategoryReportViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation

final class CategoryReportViewModel {
    weak var view: CategoryReportModuleInput?
    
    private let transactions: [FTransaction]
    private let costs: Double
    
    private var groupedTransactions: [FCategory: [FTransaction]] = [:]
    private var chartEntries: [ChartPresentable] = []
    private var categoryStat: [FCategory: Double] = [:]
    
    init(transactions: [FTransaction], costs: Double) {
        self.transactions = transactions
        self.costs = costs
        
        groupTransactions()
    }
    
    private func groupTransactions() {
        for transaction in transactions {
            let category = transaction.relatedCategory
            
            if groupedTransactions[category] == nil {
                groupedTransactions[category] = [transaction]
            } else {
                groupedTransactions[category]?.append(transaction)
            }
            if let value = categoryStat[category] {
                categoryStat[category] = value + transaction.amount
            }
            else {
                categoryStat[category] = transaction.amount
            }
        }
    }
}

extension CategoryReportViewModel: CategoryReportBuilderDataSource {
    var chartCellView: PieChartCellViewModel {
        let chartData = categoryStat.map { key, value in
            CategoryChartData(value: value, title: key.localizedName)
        }
        return .init(entries: chartData)
    }
}

