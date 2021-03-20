//
//  AccountInfoBuilder.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import TableKit

protocol AccountInfoBuilderInput {
    var accountInfoCellViewModel: AccountInfoCellViewModel { get }
    
    var transactionCellViewModels: [(String, [TransactionCellViewModel])]? { get }
}

struct AccountInfoBuilder: BaseTableBuilder {
    func buildSections(from dataSource: AccountInfoBuilderInput) -> [TableSection] {
        [
            buildAccountInfoSection(from: dataSource)
        ] + buildTransactionsSection(from: dataSource)
        
    }
    
    private func buildAccountInfoSection(from dataSource: AccountInfoBuilderInput) -> TableSection {
        let row = TableRow<AccountInfoCell>(item: dataSource.accountInfoCellViewModel)
        
        return .init(onlyRows: [row])
    }
    
    private func buildTransactionsSection(from dataSource: AccountInfoBuilderInput) -> [TableSection] {
        guard let viewModels = dataSource.transactionCellViewModels else {
            return .init()
        }
        
        var sections: [TableSection] = []
        
        for (month, transactions) in viewModels{
            let rows = transactions.map {
                TableRow<TransactionCell>(item: $0)
            }
            let header = TableSectionHeader()
            header.configure(with: month.uppercased())
            sections.append(TableSection(withHeader: header, rows: rows))
        }
        
        return sections
    }
}
