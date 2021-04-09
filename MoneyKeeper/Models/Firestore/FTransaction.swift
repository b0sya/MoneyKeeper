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
        static let relatedAccountId = "relatedAccountId"
        static let relatedAccount = "relatedAccount"
        static let relatedCategory = "relatedCategory"
    }
    
    static var collectionKey = "Transactions"
    
    let uid: String
    let amount: Double
    let date: Date
    let note: String?
    let direction: DirectionType
    let relatedAccountId: String
    let relatedAccount: FAccount
    let relatedCategory: FCategory
    
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
            Keys.relatedAccountId: relatedAccount.uid,
            Keys.relatedAccount: relatedAccount.dictionaryRepresentation,
            Keys.relatedCategory: relatedCategory.dictionaryRepresentation,
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
         relatedAccount: FAccount,
         relatedCategory: FCategory) {
        self.uid = uid
        self.amount = amount
        self.date = date
        self.note = note
        self.direction = direction
        self.relatedAccount = relatedAccount
        self.relatedCategory = relatedCategory
        self.relatedAccountId = relatedAccount.uid
    }
    
    init?(from data: [String: Any]) {
        guard let uid = data[Keys.uid] as? String,
              let amount = data[Keys.amount] as? Double,
              let date = data[Keys.date] as? Timestamp,
              let directionRawValue = data[Keys.direction] as? Int16,
              let direction = DirectionType(rawValue: directionRawValue),
              let relatedAccountData = data[Keys.relatedAccount] as? [String: Any],
              let account = FAccount(from: relatedAccountData),
              let categoryData = data[Keys.relatedCategory] as? [String: Any],
              let category = FCategory(from: categoryData) else {
            return nil
        }
        
        self.uid = uid
        self.amount = amount
        self.date = date.dateValue()
        self.direction = direction
        self.relatedAccount = account
        self.relatedCategory = category
        self.note = data[Keys.note] as? String
        self.relatedAccountId = account.uid
    }
}
