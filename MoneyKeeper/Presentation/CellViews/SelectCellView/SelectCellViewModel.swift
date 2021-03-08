//
//  SelectCellViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

final class SelectCellViewModel: TappableCellViewModel {
    weak var cell: SelectCellView?
    
    let title: String
    let isRequired: Bool
    
    var value: String? {
        didSet {
            cell?.textField.text = value
        }
    }
    var placeholder: String {
        isRequired ? .required : .notRequired
    }

    init(title: String,
         value: String?,
         isRequired: Bool,
         tapAction: VoidClosure? = nil) {
        self.title = title
        self.value = value
        self.isRequired = isRequired

        super.init(tapAction: tapAction)
    }
}
