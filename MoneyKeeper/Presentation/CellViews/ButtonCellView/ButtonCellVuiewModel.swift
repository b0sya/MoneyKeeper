//
//  ButtonCellVuiewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation

final class ButtonCellViewModel {
    weak var view: ButtonCellView?
    
    var isEnabled: Bool = false {
        didSet {
            view?.button.isEnabled = isEnabled
        }
    }
    
    let buttonTitle: String
    var buttonAction: VoidClosure?
    
    init(buttonTitle: String,
         buttonAction: VoidClosure? = nil) {
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
}
