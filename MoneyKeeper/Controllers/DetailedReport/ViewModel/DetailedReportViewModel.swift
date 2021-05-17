//
//  CategoryReportViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import UIKit

final class DetailedReportViewModel {
    weak var view: DetailedReportModuleInput?
    
    private let firebaseStorage = FirebaseStorage.instance
    
    private let transactions: [FTransaction]
    private let totalValue: Double
    
    private var categories: [String: FCategory] = [:]
    
    private var chartEntries: [ChartPresentable] = []
    private var totalForGroups: [String: Double] = [:]
    
    private let direction: DirectionType
    
    private var subcategoryMode = false
    
    init(transactions: [FTransaction], totalValue: Double) {
        self.transactions = transactions
        self.totalValue = totalValue
        
        self.direction = DirectionType(rawValue: transactions.first?.relatedCategory.directonId ?? 0) ?? .cost
    }
    
    init(transactions: [FTransaction], categories: [String: FCategory], totalValue: Double) {
        self.transactions = transactions
        self.categories = categories
        self.totalValue = totalValue
        
        self.direction = DirectionType(rawValue: transactions.first?.relatedCategory.directonId ?? 0) ?? .cost
        
        subcategoryMode = true
        
    }
    
    func loadCateegories() {
        guard categories.isEmpty else {
            groupTransactions()
            return
        }
        
        firebaseStorage.fetchCategories(direction: direction) { result in
            switch result {
            case .success(let data):
                data.forEach {
                    self.categories[$0.uid] = $0
                }
                self.groupTransactions()
            case .failure(let error):
                break
            }
        }
    }
    
    private func groupTransactions() {        
        for transaction in transactions {
            let category = transaction.relatedCategory
            
            let id: String
            if subcategoryMode {
                id = category.uid
            } else {
                id = (category.parentCategoryId?.isEmpty ?? true) ? category.uid : category.parentCategoryId ?? ""
            }
            
            if let value = totalForGroups[id] {
                totalForGroups[id] = value + transaction.mainAmount
            } else {
                totalForGroups[id] = transaction.mainAmount
            }
        }
        view?.fillTable()
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
        totalForGroups.compactMap { key, value in
            guard let category = categories[key] else {
                return nil
            }
            guard !category.subcategoryIds.isEmpty else {
                return AccountCellViewModel(title: category.localizedName,
                                            value: value,
                                            icon: nil,
                                            tapAction: nil)
            }
            var categories: [String: FCategory] = [:]
            
            category.subcategoryIds.forEach {
                categories[$0] = self.categories[$0]
            }
            
            categories[category.uid] = category
            
            return AccountCellViewModel(title: category.localizedName,
                                        value: value,
                                        icon: nil) { [self] in
                self.view?.onShowSubcategories?((self.transactions, categories, value))
            }
            
        }
    }
    
    var chartCellView: PieChartCellViewModel {
        let chartData = totalForGroups.compactMap { (key, value) -> CategoryChartData? in
            
            guard let categoryName = categories[key]?.localizedName else {
                return nil
            }
            
            return CategoryChartData(value: ((value*100)/totalValue),
                              title: categoryName,
                              color: generateColor())
        }
        return .init(entries: chartData)
    }
}

