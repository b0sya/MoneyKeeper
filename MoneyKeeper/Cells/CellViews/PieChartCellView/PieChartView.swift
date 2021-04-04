//
//  PieChartView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Charts
import UIKit

final class PieChartCellView: RoundedContainerCellView {
    private let pieChart = PieChartView()
    
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
        
        pieChart.drawEntryLabelsEnabled = false
    }
    
    private func configurePieChart(for viewModel: PieChartCellViewModel) {
        let entries = viewModel.entries.map {
            PieChartDataEntry(value: $0.value, label: $0.title)
        }
        
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = colorsOfCharts(numbersOfColor: entries.count)
        let data = PieChartData(dataSet: dataSet)
         
        pieChart.data = data
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
}

extension PieChartCellView: ConfigurableView {
    func configure(with viewModel: PieChartCellViewModel) {
        configurePieChart(for: viewModel)
    }
}
