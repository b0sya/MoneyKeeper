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
    }
    
    static var collectionKey = "Categories"
    
    let uid: String
    let name: String
    let directonId: Int16
    var reference: DocumentReference? = nil
    
    var dictionaryRepresentation: [String : Any] {
        [
            "uid": uid,
            "name": name,
            "directionId": directonId,
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
    }
    
    init?(from data: [String: Any]) {
        guard let uid = data[Keys.uid] as? String,
              let directionId = data[Keys.directionId] as? Int16,
              let name = data[Keys.name] as? String else {
            return nil
        }
        self.uid = uid
        self.name = name
        self.directonId = directionId
    }
}
