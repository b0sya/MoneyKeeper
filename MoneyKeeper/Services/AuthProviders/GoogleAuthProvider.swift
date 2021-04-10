//
//  GoogleAuthProvider.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 10.03.2021.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

final class GoogleAuth: NSObject, AuthProvider {
    private var successCompletion: VoidClosure?
    private var failureCompletion: VoidClosure?
    
    static var isAuthorized: Bool {
        Auth.auth().currentUser != nil
    }
        
    override init() {
        super.init()
        
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func signIn(from vc: UIViewController, successCompletion: VoidClosure?, failureCompletion: VoidClosure?) {
        self.successCompletion = successCompletion
        self.failureCompletion = failureCompletion
        
        GIDSignIn.sharedInstance()?.presentingViewController = vc
        GIDSignIn.sharedInstance().signIn()
    }
    
    static func logOut(successCompletion: VoidClosure?, failureCompletion: ParameterClosure<Error>?) {
        do {
            try Auth.auth().signOut()
            successCompletion?()
        } catch let signOutError as NSError {
            failureCompletion?(signOutError)
        }
    }
}

extension GoogleAuth: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let _ = error {
                self.failureCompletion?()
                return
            }
            self.successCompletion?()
        }
    }
}
