//
//  CACornerMask+RoundedCorners.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

public extension CACornerMask {
    static var topCorners: Self {
        [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    static var bottomCorners: Self {
        [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    static var allCorners: Self {
        [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }
}
