//
//  TappableCellViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import Foundation

class TappableCellViewModel {
    var onTap: VoidClosure?

    init(tapAction: VoidClosure?) {
        onTap = tapAction
    }
}
