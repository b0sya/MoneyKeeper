//
//  LoginViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 08.03.2021.
//

import Foundation
import AuthenticationServices

protocol LoginModule: Presentable {
    var onSuccessSignIn: VoidClosure? { get set }
}

final class LoginViewController: BaseViewController<LoginView, LoginViewModel>, LoginModule {
    var onSuccessSignIn: VoidClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.googleButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    @objc private func signIn() {
        viewModel.signIn()
    }
}
