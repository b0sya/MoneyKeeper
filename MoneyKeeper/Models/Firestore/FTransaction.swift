//
//  FTransaction.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 13.03.2021.
//

import Foundation
import FirebaseFirestore

struct FTransaction: FirestoreModel {
    struct Keys {
        static let uid = "uid"
        static let amount = "amount"
        static let date = "date"
        static let note = "note"
        static let direction = "direction"
        static let relatedAccount = "relatedAccount"
    }
    
    static var collectionKey = "Transactions"
    
    let uid: String
    let amount: Double
    let date: Date
    let note: String?
    let direction: DirectionType
    let relatedAccount: DocumentReference
    
    var reference: DocumentReference? = nil
    
    var isCostOperation: Bool {
        direction == .cost
    }
    
    var dictionaryRepresentation: [String : Any] {
        var dict: [String : Any] = [
            Keys.uid: uid,
            Keys.amount: amount,
            Keys.date: date,
            Keys.direction: direction.rawValue,
            Keys.relatedAccount: relatedAccount,
        ]
        
        if let note = note {
            dict[Keys.note] = note
        }
        
        return dict
    }
    
    init(uid: String,
         amount: Double,
         date: Date,
         note: String?,
         direction: DirectionType,
         relatedAccount: DocumentReference) {
        self.uid = uid
        self.amount = amount
        self.date = date
        self.note = note
        self.direction = direction
        self.relatedAccount = relatedAccount
    }
    
    init?(from snapshot: DocumentSnapshot) {
        guard let data = snapshot.data(),
              let uid = data[Keys.uid] as? String,
              let amount = data[Keys.amount] as? Double,
              let date = data[Keys.date] as? Timestamp,
              let directionRawValue = data[Keys.direction] as? Int16,
              let direction = DirectionType(rawValue: directionRawValue),
              let accountReference = data[Keys.relatedAccount] as? DocumentReference else {
            return nil
        }
        
        self.reference = snapshot.reference
        self.uid = uid
        self.amount = amount
        self.date = date.dateValue()
        self.direction = direction
        self.relatedAccount = accountReference
        self.note = data[Keys.note] as? String
    }
}
