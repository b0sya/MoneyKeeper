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
        static let mainAmount = "mainAmount"
        static let presentAmount = "presentAmount"
        static let currency = "currency"
        static let date = "date"
        static let note = "note"
        static let direction = "direction"
        static let relatedAccountId = "relatedAccountId"
        static let relatedAccount = "relatedAccount"
        static let relatedCategory = "relatedCategory"
    }
    
    static var collectionKey = "Transactions"
    
    let uid: String
    let mainAmount: Double
    let presentAmount: Double
    let currency: Currency
    
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
            Keys.mainAmount: mainAmount,
            Keys.presentAmount: presentAmount,
            Keys.currency: currency.rawValue,
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
         mainAmount: Double,
         presentAmount: Double,
         currency: Currency,
         date: Date,
         note: String?,
         direction: DirectionType,
         relatedAccount: FAccount,
         relatedCategory: FCategory) {
        self.uid = uid
        self.mainAmount = mainAmount
        self.presentAmount = presentAmount
        self.currency = currency
        self.date = date
        self.note = note
        self.direction = direction
        self.relatedAccount = relatedAccount
        self.relatedCategory = relatedCategory
        self.relatedAccountId = relatedAccount.uid
    }
    
    init?(from data: [String: Any]) {
        guard let uid = data[Keys.uid] as? String,
              let mainAmount = data[Keys.mainAmount] as? Double,
              let presentAmount = data[Keys.presentAmount] as? Double,
              let currency = Currency(rawValue: (data[Keys.currency] as? String) ?? ""),
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
        self.mainAmount = mainAmount
        self.presentAmount = presentAmount
        self.currency = currency
        self.date = date.dateValue()
        self.direction = direction
        self.relatedAccount = account
        self.relatedCategory = category
        self.note = data[Keys.note] as? String
        self.relatedAccountId = account.uid
    }
}
