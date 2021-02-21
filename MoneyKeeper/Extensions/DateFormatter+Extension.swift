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
}
