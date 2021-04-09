//
//  CategoryReportViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import UIKit

final class DetailedReportViewModel {
    weak var view: DetailedReportModuleInput?
    
    private let transactions: [FTransaction]
    private let totalValue: Double
    
    private var groupedTransactions: [FCategory: [FTransaction]] = [:]
    private var chartEntries: [ChartPresentable] = []
    private var totalForGroups: [FCategory: Double] = [:]
    
    init(transactions: [FTransaction], totalValue: Double) {
        self.transactions = transactions
        self.totalValue = totalValue
        
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
            if let value = totalForGroups[category] {
                totalForGroups[category] = value + transaction.amount
            }
            else {
                totalForGroups[category] = transaction.amount
            }
        }
    }
    
    private func generateColor() -> UIColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        return color
    }
}

extension DetailedReportViewModel: DetailedReportBuilderDataSource {
    var categoriesCellsViewModels: [AccountCellViewModel] {
        totalForGroups.map { key, value in
            AccountCellViewModel(title: key.localizedName,
                                 value: value,
                                 icon: nil,
                                 tapAction: nil)
        }
    }
    
    var chartCellView: PieChartCellViewModel {
        let chartData = totalForGroups.map { key, value in
            CategoryChartData(value: ((value*100)/totalValue),
                              title: key.localizedName,
                              color: generateColor())
        }
        return .init(entries: chartData)
    }
}

