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
    static var backgroundGray: UIColor {
        resourceColor(named: "backgroundGray")
    }
    
    static var backgroundWhite: UIColor {
        resourceColor(named: "backgroundWhite")
    }

    static var MKGreen: UIColor {
        resourceColor(named: "MKGreen")
    }
    
    static var blackWhite: UIColor {
        resourceColor(named: "blackWhite")
    }
    
    static var whiteBackgoundGray: UIColor {
        resourceColor(named: "whiteBackgoundGray")
    }
}
