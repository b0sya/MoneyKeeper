//
//  FAccount.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 13.03.2021.
//

import Foundation
import FirebaseFirestore

struct FAccount: FirestoreModel {
    struct Keys {
        static let uid = "uid"
        static let name = "name"
        static let balance = "balance"
    }
        
    static var collectionKey = "Accounts"
    
    let uid: String
    let name: String
    let balance: Double
    
    var dictionaryRepresentation: [String : Any] {
        [
            Keys.uid: uid,
            Keys.name: name,
            Keys.balance: balance,
        ]
    }
    
    init(uid: String,
         name: String,
         balance: Double,
         relatedTransactions: [String] = []) {
        self.uid = uid
        self.name = name
        self.balance = balance
    }
    
    init?(from data: [String: Any]) {
        guard let uid = data[Keys.uid] as? String,
              let name = data[Keys.name] as? String,
              let balance = data[Keys.balance] as? Double else {
            return nil
        }
        
        self.uid = uid
        self.name = name
        self.balance = balance
    }
}
