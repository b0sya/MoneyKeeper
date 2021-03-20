//
//  AuthProviderButton.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 08.03.2021.
//

import UIKit

class AuthProviderButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        imageEdgeInsets.left = 9
        titleEdgeInsets = UIEdgeInsets(top: 0, left: (availableWidth / 2), bottom: 0, right: 0)
    }
    
}
