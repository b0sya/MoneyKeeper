//
//  SettingsView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 10.04.2021.
//

import UIKit

final class SettingsView: BaseView {
    let logoutButton = UIButton()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(logoutButton)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        logoutButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .backgroundGray
        
        logoutButton.setBackgroundColor(.red, for: .normal)
        logoutButton.layer.cornerRadius = CGFloat.buttonCornerRadius
        logoutButton.setTitle(.logOut, for: .normal)
    }
}
