//
//  ReportCategoryView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 26.03.2021.
//

import Foundation

struct ReportCategoryViewModel {
    let title: String
    let value: String
    
    var tapAction: VoidClosure?
    
    init(title: String, value: String, tapAction: VoidClosure? = nil) {
        self.title = title
        self.value = value
        
        self.tapAction = tapAction
    }
    
    init(title: String, amount: Double, tapAction: VoidClosure? = nil) {
        let value = NumberFormatter.rubFormatter.string(from: NSNumber(value: amount)) ?? "!ERROR!"
        
        self.init(title: title, value: value, tapAction: tapAction)
    }
}
