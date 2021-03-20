//
//  Date+CompareDates.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 19.03.2021.
//

import Foundation

extension Date {
    func isSameDay(for date: Date) -> Bool {
        let components: Set<Calendar.Component> = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day]
        
        let currentDateComponents = Calendar.current.dateComponents(components, from: self)
        let dateComponents = Calendar.current.dateComponents(components, from: date)
        
        return currentDateComponents.year == dateComponents.year
            && currentDateComponents.month == dateComponents.month
            && currentDateComponents.day == dateComponents.day
    }
}
