//
//  MainBuilder.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import Foundation
import TableKit

typealias DefaultCell = DefaultCellContainer<DefaultCellView>

protocol MainBuilderDataSource {
    var accountsCellsViewModels: [DefaultCellViewModel] { get }

    var serviceCellsViewModel: [DefaultCellViewModel] { get }
}

final class MainBuilder {
    func buildSections(from dataSource: MainBuilderDataSource) -> [TableSection] {
        [
            buildSection(from: dataSource.accountsCellsViewModels),
            buildSection(from: dataSource.serviceCellsViewModel),
        ]

    }

    private func buildSection(from viewModels: [DefaultCellViewModel]) -> TableSection {
        let rows = viewModels.compactMap { item -> TableRow<DefaultCell>? in
            TableRow<DefaultCell>(item: item)
        }
        let section = TableSection(headerView: nil, footerView: nil, rows: rows)
        section.headerView = UIView()
        section.headerHeight = 30
        section.footerHeight = .leastNonzeroMagnitude
        return section
    }
}
