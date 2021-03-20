//
//  Images.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import UIKit

extension UIImage {

    private static func resourceImage(named: String) -> UIImage{
        guard let image = UIImage(named: named) else {
            return UIImage()
        }
        return image
    }

    static var arrowRight: UIImage {
        return resourceImage(named: "arrow-right")
    }

    static var addIcon: UIImage {
        return resourceImage(named: "add")
    }

    static var removeIcon: UIImage {
        return resourceImage(named: "remove")
    }
    
    static var googleLogo: UIImage {
        return resourceImage(named: "googleLogo")
    }
    
    
}
