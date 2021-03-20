//
//  FirestoreModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 13.03.2021.
//

import Foundation
import FirebaseFirestore

protocol FirestoreModel {
    static var collectionKey: String { get }
    
    var dictionaryRepresentation: [String: Any] { get }
    
    var reference: DocumentReference? { get }
    
    init?(from snapshot: DocumentSnapshot)
}
