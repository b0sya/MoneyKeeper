//
//  DefaultCellViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 29.01.2021.
//

import UIKit

final class DefaultCellViewModel: TappableCellViewModel {
    let title: String
    let value: String?
    let icon: UIImage?

    init(title: String,
         value: String?,
         icon: UIImage?,
         tapAction: (()->())?
    ) {
        self.title = title
        self.value = value
        self.icon = icon

        super.init(tapAction: tapAction)
    }
    
}
