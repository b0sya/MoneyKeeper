//
//  MKNavigationController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import UIKit

final class MKNavigationController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .MKGreen
	}
}
