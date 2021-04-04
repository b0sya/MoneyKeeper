//
//  Date+Periods.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

import Foundation

extension Date {
    var startOfMonth: Date {
        
        let calendar = Calendar(identifier: .iso8601)
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return  calendar.date(from: components)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .iso8601).date(byAdding: components, to: startOfMonth)!
    }
    
    var startOfWeek: Date {
        let calendar = Calendar(identifier: .iso8601)
        let components = calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self)
        
        return  calendar.date(from: components)!
    }
    
    var endOfWeek: Date {
        var components = DateComponents()
        components.weekOfMonth = 1
        components.second = -1
        return Calendar(identifier: .iso8601).date(byAdding: components, to: startOfWeek)!
    }
    
    var startOfYear: Date {
        let calendar = Calendar(identifier: .iso8601)
        let components = calendar.dateComponents([.year], from: self)
        
        return  calendar.date(from: components)!
    }
    
    var endOfYear: Date {
        var components = DateComponents()
        components.year = 1
        components.day = -1
        return Calendar(identifier: .iso8601).date(byAdding: components, to: startOfYear)!
    }
    
    static var currentMonthPeriod: Period {
        let date = Date()
        return (date.startOfMonth, date.endOfMonth)
    }
    
    static var currentWeekPeriod: Period {
        let date = Date()
        return (date.startOfWeek, date.endOfWeek)
    }
    
    static var currentYearPeriod: Period {
        let date = Date()
        return (date.startOfYear, date.endOfYear)
    }
}
