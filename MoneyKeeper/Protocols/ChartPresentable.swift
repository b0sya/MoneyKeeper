//
//  ChartPresentable.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import UIKit

protocol ChartPresentable {
    var value: Double { get }
    var title: String { get }
    var color: UIColor? { get }
}
