//
//  FCategory.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 13.03.2021.
//

import Foundation
import FirebaseFirestore

struct FCategory: FirestoreModel, Hashable {
    enum Keys: String {
        case uid = "uid"
        case name = "name"
        case parentCategoryId = "parentCategoryId"
        case subcategoryIds = "subcategoryIds"
        case directionId = "directionId"
    }
    
    static var collectionKey = "Categories"
    
    let uid: String
    let name: String
    let directonId: Int16
    
    let parentCategoryId: String?
    var subcategoryIds: [String] = []
    
    var dictionaryRepresentation: [String : Any] {
        [
            Keys.uid.rawValue: uid,
            Keys.name.rawValue: name,
            Keys.directionId.rawValue: directonId,
            Keys.subcategoryIds.rawValue: subcategoryIds,
            Keys.parentCategoryId.rawValue: parentCategoryId ?? ""
        ]
    }
    
    var localizedName: String {
        NSLocalizedString(name, comment: "")
    }
    
    init(uid: String,
         name: String,
         direction: DirectionType,
         parentCategoryId: String?) {
        self.uid = uid
        self.name = name
        self.directonId = direction.rawValue
        self.parentCategoryId = parentCategoryId
    }
    
    init?(from data: [String: Any]) {
        guard let uid = data[Keys.uid.rawValue] as? String,
              let directionId = data[Keys.directionId.rawValue] as? Int16,
              let name = data[Keys.name.rawValue] as? String,
              let subcategoryIds = data[Keys.subcategoryIds.rawValue] as? [String],
              let parentCategoryId = data[Keys.parentCategoryId.rawValue] as? String else {
            return nil
        }
        
        self.uid = uid
        self.name = name
        self.directonId = directionId
        self.parentCategoryId = parentCategoryId
        self.subcategoryIds = subcategoryIds
        
    }
}
