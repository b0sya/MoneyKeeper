//
//  SettingsViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 10.04.2021.
//

import UIKit

typealias SettingsModuleInput = SettingsModule & SettingsInput

protocol SettingsModule: Presentable {
    var onLoggedOut: VoidClosure? { get set }
}

protocol SettingsInput: ErrorPresentable {
}

final class SettingsViewController: BaseViewController<SettingsView, SettingsViewModel>, SettingsModuleInput {
    var onLoggedOut: VoidClosure?
    
    override func configureAppearance() {
        super.configureAppearance()
        
        baseView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    override func localize() {
        super.localize()
        
        title = .settings
    }
    
    @objc private func logoutButtonTapped() {
        viewModel.logout()
    }
}
