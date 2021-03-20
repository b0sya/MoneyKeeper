//
//  TableSection+OnlyRows.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//
import TableKit

extension TableSection {
    convenience init(onlyRows rows: [Row]) {
        self.init(rows: rows)

        self.headerView = nil
        self.footerView = nil

        self.headerHeight = .leastNonzeroMagnitude
        self.footerHeight = .leastNonzeroMagnitude
    }
    
    convenience init(withHeader: UIView, rows: [Row]) {
        self.init(rows: rows)
        
        self.headerView = withHeader
        self.headerHeight = 46
        
        self.footerView = nil
        
        self.footerHeight = .leastNonzeroMagnitude
    }
    
    convenience init(withEmptyHeader rows: [Row]) {
        self.init(rows: rows)
        
        self.footerHeight = .leastNonzeroMagnitude
        self.headerView = UIView()
        self.headerHeight = 30
    }
}
