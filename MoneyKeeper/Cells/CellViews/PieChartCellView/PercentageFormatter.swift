//
//  PercentageFormatter.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 04.04.2021.
//

import Foundation
import Charts

class PercentageChartsFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        "\(Int(value))%"
    }
}
