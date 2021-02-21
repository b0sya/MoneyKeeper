//
//  SelectCellViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import Foundation

final class SelectCellViewModel: TappableCellViewModel {
    let title: String
    let isRequired: Bool

    var placeholder: String {
        isRequired ? .requiredFieldPlaceholder : .notRequiredFieldPlaceholder
    }

    init(title: String,
         isRequired: Bool,
         tapAction: VoidClosure?) {
        self.title = title
        self.isRequired = isRequired

        super.init(tapAction: tapAction)
    }
}
