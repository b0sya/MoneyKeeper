//
//  DatePickerCellView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 07.02.2021.
//

import UIKit

final class DatePickerCellView: TextFieldCellView {
    var onDatePickerDonePressed: ParameterClosure<Date>?
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 14, *) {
          datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()

    private let toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: 0, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: .cancel, style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: .done, style: .plain, target: target, action: #selector(doneTapped))
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        return toolBar
    }()

    override func configureAppearance() {
        super.configureAppearance()

        textField.text = DateFormatter.dayMonthWordYearTimeFormatter.string(from: Date())

        textField.inputView = datePicker
        textField.inputAccessoryView = toolBar
    }

    @objc private func doneTapped() {
        textField.text = DateFormatter.dayMonthWordYearTimeFormatter.string(from: datePicker.date)
        onDatePickerDonePressed?(datePicker.date)
        tapCancel()
    }

    @objc private func tapCancel() {
        textField.resignFirstResponder()
    }
}
