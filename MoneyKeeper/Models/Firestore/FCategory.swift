//
//  FCategory.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 13.03.2021.
//

import Foundation
import FirebaseFirestore

struct FCategory: FirestoreModel {
    struct Keys {
        static let uid = "uid"
        static let name = "name"
        static let directionId = "directionId"
        static let relatedTransactions = "relatedTransactions"
    }
    
    static var collectionKey = "Categories"
    
    let uid: String
    let name: String
    let directonId: Int16
    let relatedTransactions: [DocumentReference]
    var reference: DocumentReference? = nil
    
    var dictionaryRepresentation: [String : Any] {
        [
            "uid": uid,
            "name": name,
            "directionId": directonId,
            "relatedTransactions": relatedTransactions
        ]
    }
    
    var localizedName: String {
        NSLocalizedString(name, comment: "")
    }
    
    init(uid: String,
         name: String,
         direction: DirectionType,
         relatedTransactions: [DocumentReference] = []) {
        self.uid = uid
        self.name = name
        self.directonId = direction.rawValue
        self.relatedTransactions = relatedTransactions
    }
    
    init?(from snapshot: DocumentSnapshot) {
        guard let data = snapshot.data(),
              let uid = data[Keys.uid] as? String,
              let directionId = data[Keys.directionId] as? Int16,
              let name = data[Keys.name] as? String else {
            return nil
        }
        self.reference = snapshot.reference
        self.uid = uid
        self.name = name
        self.directonId = directionId
        self.relatedTransactions = data[Keys.relatedTransactions] as? [DocumentReference] ?? []
    }
}
