//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Максим Шалашников on 07.03.2021.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var icon: Data?
    @NSManaged public var name: String?
    @NSManaged public var uid: UUID?
    @NSManaged public var relatedTransactions: NSOrderedSet?

}

// MARK: Generated accessors for relatedTransactions
extension Category {

    @objc(insertObject:inRelatedTransactionsAtIndex:)
    @NSManaged public func insertIntoRelatedTransactions(_ value: Transaction, at idx: Int)

    @objc(removeObjectFromRelatedTransactionsAtIndex:)
    @NSManaged public func removeFromRelatedTransactions(at idx: Int)

    @objc(insertRelatedTransactions:atIndexes:)
    @NSManaged public func insertIntoRelatedTransactions(_ values: [Transaction], at indexes: NSIndexSet)

    @objc(removeRelatedTransactionsAtIndexes:)
    @NSManaged public func removeFromRelatedTransactions(at indexes: NSIndexSet)

    @objc(replaceObjectInRelatedTransactionsAtIndex:withObject:)
    @NSManaged public func replaceRelatedTransactions(at idx: Int, with value: Transaction)

    @objc(replaceRelatedTransactionsAtIndexes:withRelatedTransactions:)
    @NSManaged public func replaceRelatedTransactions(at indexes: NSIndexSet, with values: [Transaction])

    @objc(addRelatedTransactionsObject:)
    @NSManaged public func addToRelatedTransactions(_ value: Transaction)

    @objc(removeRelatedTransactionsObject:)
    @NSManaged public func removeFromRelatedTransactions(_ value: Transaction)

    @objc(addRelatedTransactions:)
    @NSManaged public func addToRelatedTransactions(_ values: NSOrderedSet)

    @objc(removeRelatedTransactions:)
    @NSManaged public func removeFromRelatedTransactions(_ values: NSOrderedSet)

}
