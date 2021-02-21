//
//  CoreDataManager.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import Foundation
import CoreData
import UIKit

enum CoreDataError: Error {
    case saveContextError
    case loadDataError
}

typealias CDAccountsCompletion = Result<Account, CoreDataError>

class StorageProvider {

    static let shared = StorageProvider()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoneyKeeper")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {}

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getAccounts(completion: (Result<[Account], CoreDataError>) -> ()) {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()

        do {
            let results = try context.fetch(fetchRequest)
            completion(.success(results))
        } catch {
            completion(.failure(.loadDataError))
        }
    }

    func isertAccount(name:String,
                    currency: Double?,
                    icon: UIImage?,
                    completion: (Result<Account, CoreDataError>) -> ()) {
        let account = Account(context: context)

        account.id = UUID()
        account.name = name

        if let currency = currency {
            account.currency = currency
        }

        if let image = icon {
            account.icon = image.pngData()
        }

        do {
            try self.context.save()
            completion(.success(account))
        } catch {
            completion(.failure(.saveContextError))
        }
    }
}
