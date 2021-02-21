//
//  Account+CoreDataProperties.swift
//  
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var currency: Double
    @NSManaged public var icon: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var relatedTransactions: NSOrderedSet?

}

// MARK: Generated accessors for relatedTransactions
extension Account {

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
