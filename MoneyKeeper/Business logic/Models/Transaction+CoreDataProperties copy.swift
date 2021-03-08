//
//  Transaction+CoreDataProperties.swift
//  
//
//  Created by Максим Шалашников on 07.03.2021.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var note: String?
    @NSManaged public var direction: Int16
    @NSManaged public var relatedAccount: Account?
    @NSManaged public var relatedCategory: Category?

}
