//
//  Typealias.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import Foundation

typealias ParameterClosure<T> = (T) -> ()
typealias VoidClosure = () -> ()

typealias SelectTextFieldCell = DefaultCellContainer<SelectCellView>
typealias TextFieldCell = DefaultCellContainer<TextFieldCellView>
typealias ButtonCell = DefaultCellContainer<ButtonCellView>
typealias DatePickerCell = DefaultCellContainer<DatePickerCellView>
typealias TitleCell = DefaultCellContainer<TitleCellView>
typealias SegmentedControlCell = DefaultCellContainer<SegmentedControlCellView>
typealias AccountInfoCell = DefaultCellContainer<AccountInfoCellView>
typealias TransactionCell = TransactionsListCellContainer<TransactionCellView>
