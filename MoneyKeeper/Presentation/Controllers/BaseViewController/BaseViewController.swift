//
//  BaseViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 17.01.2021.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    private(set) var mainView = View()
    
    override func loadView() {
        view = mainView
    }
    
}
