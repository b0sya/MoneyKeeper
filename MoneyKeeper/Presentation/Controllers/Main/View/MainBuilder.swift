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
    var addAccountViewModel: TappableCellViewModel { get }
    var accountsCellsViewModels: [AccountCellViewModel] { get }

    var serviceCellsViewModel: [DefaultCellViewModel] { get }
}

struct MainBuilder {

    typealias AddAccountCell = DefaultCellContainer<CenterIconCellView>
    typealias AccountCell = DefaultCellContainer<AccountCellView>

    func buildSections(from dataSource: MainBuilderDataSource) -> [TableSection] {
        [
            buildAccountsSection(from: dataSource),
            buildServicesSection(from: dataSource),
        ]

    }

    func buildAccountsSection(from dataSource: MainBuilderDataSource) -> TableSection {
        var rows: [Row] = dataSource.accountsCellsViewModels
            .compactMap { item -> TableRow<AccountCell>? in
                TableRow<AccountCell>(item: item).on(.click) { _ in
                    item.onTap?()
                }
            }
        let addAccountRow = TableRow<AddAccountCell>(item: dataSource.addAccountViewModel)
            .on(.click) { _ in
                dataSource.addAccountViewModel.onTap?()
            }

        rows.append(addAccountRow)

        return .init(onlyRows: rows)
    }

    private func buildServicesSection(from dataSource: MainBuilderDataSource) -> TableSection {
        let rows = dataSource.serviceCellsViewModel
            .compactMap { item -> TableRow<DefaultCell>? in
                TableRow<DefaultCell>(item: item).on(.click) { _ in
                    item.onTap?()
                }
        }

        let section = TableSection(rows: rows)

        section.headerView = UIView()
        section.headerHeight = 30
        section.footerHeight = .leastNonzeroMagnitude
        
        return section
    }
}
