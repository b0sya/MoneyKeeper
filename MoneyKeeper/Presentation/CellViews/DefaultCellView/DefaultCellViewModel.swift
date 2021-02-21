//
//  DefaultCellViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 29.01.2021.
//

import UIKit

class DefaultCellViewModel: TappableCellViewModel {
    let title: String
    let icon: UIImage?

    init(title: String,
         icon: UIImage?,
         tapAction: VoidClosure?) {
        self.title = title
        self.icon = icon

        super.init(tapAction: tapAction)
    }
    
}
