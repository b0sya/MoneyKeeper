//
//  DateFormatter+Extension.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 07.02.2021.
//

import Foundation

extension DateFormatter {
    /// Форматирует дату в формат "27 авг. 10:10"
    static let dayMonthWordYearTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "d MMM YYYY, h:mm"

        return dateFormatter
    }()
    
    /// Форматирует дату в формат "Ноябрь 2018"
    static let monthYearFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        
        return dateFormatter
    }()
    
    /// Форматирует дату в формат "27 авг"
    static let dayMonthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        
        return dateFormatter
    }()
    
    /// Форматирует дату в формат "27 авг  2018"
    static let dayMonthWordYearFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM YYYY"
        
        return dateFormatter
    }()
    
    /// Форматирует дату в формат "10:10"
    static let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        
        return dateFormatter
    }()
    
    static let monthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        return dateFormatter
    }()
}
