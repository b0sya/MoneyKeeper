//
//  LoginViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 08.03.2021.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

final class LoginViewModel: NSObject {
    weak var view: LoginViewController?
    
    private let googleAuthService: AuthProvider = GoogleAuth()
    
    func signIn() {
        guard let view = view else { return }
        
        googleAuthService.signIn(from: view) { [weak view] in
            view?.onSuccessSignIn?()
        } failureCompletion: {
            print("ERROR")
        }

    }
}
