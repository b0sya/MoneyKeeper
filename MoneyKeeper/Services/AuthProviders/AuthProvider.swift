//
//  AuthProvider.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 10.03.2021.
//

import UIKit

protocol AuthProvider {
    static var isAuthorized: Bool { get }
    
    func signIn(from vc: UIViewController, successCompletion: VoidClosure?, failureCompletion: VoidClosure?)
}
