//
//  Colors.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import UIKit

extension UIColor {

    private static func resourceColor(named: String) -> UIColor {
        guard let color = UIColor(named: named) else {
            assertionFailure("Unable to find color named \(named)")
            return .clear
        }

        return color
    }
    static var background: UIColor {
        resourceColor(named: "background")
    }
}
