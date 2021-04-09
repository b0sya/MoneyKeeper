//
//  PieChartView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Charts
import UIKit

final class PieChartCellView: RoundedContainerCellView {
    private let pieChart = PieChartView.default
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(pieChart)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        pieChart.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
            $0.width.equalTo(pieChart.snp.height)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    
    }
    
    private func configurePieChart(for viewModel: PieChartCellViewModel) {
        let entries = viewModel.entries.map {
            PieChartDataEntry(value: $0.value, label: $0.title)
        }
        
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = viewModel.entries.compactMap { $0.color }
        dataSet.label = ""
        
        let data = PieChartData(dataSet: dataSet)
        data.setValueFormatter(DefaultValueFormatter(formatter: .perscntage))
                 
        pieChart.data = data
    }
}

extension PieChartCellView: ConfigurableView {
    func configure(with viewModel: PieChartCellViewModel) {
        configurePieChart(for: viewModel)
    }
}
