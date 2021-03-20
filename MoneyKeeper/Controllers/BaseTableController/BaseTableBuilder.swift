//
//  BaseTableBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import Foundation
import TableKit

protocol BaseTableBuilder {
	associatedtype DataSource
	
	init()
	
	func buildSections(from dataSource: DataSource) -> [TableSection]
}
