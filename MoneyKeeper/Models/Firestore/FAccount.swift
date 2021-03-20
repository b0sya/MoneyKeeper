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
        static let relatedTransactionIds = "relatedTransactions"
    }
    
    var reference: DocumentReference? = nil
    
    static var collectionKey = "Accounts"
    
    let uid: String
    let name: String
    let balance: Double
    let relatedTransactionIds: [String]
    
    var dictionaryRepresentation: [String : Any] {
        [
            Keys.uid: uid,
            Keys.name: name,
            Keys.balance: balance,
            Keys.relatedTransactionIds: relatedTransactionIds
        ]
    }
    
    init(uid: String,
         name: String,
         balance: Double,
         relatedTransactions: [String] = []) {
        self.uid = uid
        self.name = name
        self.balance = balance
        self.relatedTransactionIds = relatedTransactions
    }
    
    init?(from snapshot: DocumentSnapshot) {
        guard let data = snapshot.data(),
              let uid = data[Keys.uid] as? String,
              let name = data[Keys.name] as? String,
              let balance = data[Keys.balance] as? Double else {
            return nil
        }
        
        self.reference = snapshot.reference
        self.uid = uid
        self.name = name
        self.balance = balance
        self.relatedTransactionIds = data[Keys.relatedTransactionIds] as? [String] ?? []
    }
}
