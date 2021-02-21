//
//  Presentable.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import UIKit

protocol Presentable: class {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  func toPresent() -> UIViewController? {
    return self
  }
}
