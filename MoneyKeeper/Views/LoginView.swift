//
//  LoginView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 08.03.2021.
//

import UIKit

final class LoginView: BaseView {
    private let titleLabel = UILabel()
    let stackView = UIStackView()
    let googleButton = AuthProviderButton()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(titleLabel)
        addSubview(stackView)
        
        stackView.addArrangedSubview(googleButton)
    }
    
    override func configureLayout() {
        super.addSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(snp.topMargin).inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(snp.bottomMargin).inset(16)
        }
        
        googleButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    override func configureAppearance() {
        super.addSubviews()
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        backgroundColor = .MKGreen
        
        titleLabel.text = .loginPromoTitle
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        googleButton.setBackgroundColor(.white, for: .normal)
        googleButton.setBackgroundColor(.white, for: .selected)
        googleButton.setTitle(.signInWithGoogle, for: .normal)
        googleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        googleButton.setTitleColor(.black, for: .normal)
        googleButton.layer.cornerRadius = CGFloat.buttonCornerRadius
        googleButton.setImage(.googleLogo, for: .normal)
    }
    
    
}
