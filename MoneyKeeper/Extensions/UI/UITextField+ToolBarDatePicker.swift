//
//  UITextField+ToolBarDatePicker.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 07.02.2021.
//

import UIKit

extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
            if #available(iOS 14, *) {
              datePicker.preferredDatePickerStyle = .wheels
            }
            self.inputView = datePicker

            // Create a toolbar and assign it to inputAccessoryView
            let toolBar = UIToolbar()
            let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancel = UIBarButtonItem(title: "Отмена", style: .plain, target: nil, action: #selector(tapCancel))
            let barButton = UIBarButtonItem(title: "Готово", style: .plain, target: target, action: selector)
            toolBar.setItems([cancel, flexible, barButton], animated: false)
            self.inputAccessoryView = toolBar
        }

        @objc func tapCancel() {
            self.resignFirstResponder()
        }
}
