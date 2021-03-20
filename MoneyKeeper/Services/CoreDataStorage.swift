//
//  CoreDataManager.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import Foundation
import CoreData
import UIKit
import FirebaseFirestore

enum CoreDataError: Error {
    case saveContextError
    case loadDataError
}

typealias CDAccountsCompletion = Result<Account, CoreDataError>

class CoreDataStorage {
    
    static let shared = CoreDataStorage()
    
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
    
    private init() {
        loadInitialCategoriesIfNeeded()
    }
    
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
}

extension CoreDataStorage {
    func getAccounts(completion: ParameterClosure<Result<[Account], CoreDataError>>?) {
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            completion?(.success(results))
        } catch {
            completion?(.failure(.loadDataError))
        }
    }
    
    func getCategories(completion: ParameterClosure<Result<[Category], CoreDataError>>?) {
        let fetchREquest: NSFetchRequest<Category> = Category.fetchRequest()

        do {
            let results = try context.fetch(fetchREquest)
            completion?(.success(results))
        } catch {
            completion?(.failure(.loadDataError))
        }
        
    }
    
    func isertAccount(name:String,
                      currency: Double?,
                      icon: UIImage?,
                      completion: ParameterClosure<Result<Account, CoreDataError>>?) {
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
//            completion?(.success(account))
        } catch {
            completion?(.failure(.saveContextError))
        }
        
        let db = Firestore.firestore()
                
        db.collection("Accounts").addDocument(data: ["id": account.id?.uuidString, "name": account.name, "currency": account.currency]) { error in
            if let _ = error {
                completion?(.failure(.saveContextError))
                return
            }
            
            completion?(.success(account))
        }
    }
    
    func insertTransaction(amount: Double,
                           category: Category,
                           date: Date,
                           description: String?,
                           account: Account,
                           direction: DirectionType,
                           completion: ParameterClosure<Result<Transaction, CoreDataError>>?) {
        let transaction = Transaction(context: context)
        
        transaction.amount = amount
        transaction.date = date
        transaction.image = nil
        transaction.note = description
        transaction.relatedCategory = category
        transaction.relatedAccount = account
        transaction.direction = direction.rawValue
        
        if direction == .cost {
            account.currency -= transaction.amount
        }
        else {
            account.currency += transaction.amount
        }
        
        
        do {
            try self.context.save()
            completion?(.success(transaction))
        } catch {
            print(error.localizedDescription)
            completion?(.failure(.saveContextError))
        }
    }
    
    private func loadInitialCategoriesIfNeeded() {
        guard !UserDefaults.standard.bool(forKey: Keys.initialCategoriesWasLoaded) else {
            return
        }
        
        UserDefaults.standard.setValue(true, forKey: Keys.initialCategoriesWasLoaded)
        
        guard let pathToFile = Bundle.main.path(forResource: "categoriesInitial", ofType: "plist") else { return }
        
        guard let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        for dictionary in dataArray {
            let category = Category(context: context)
            
            let carDictionary = dictionary as! NSDictionary
            
            guard let name = carDictionary["name"] as? String else {
                fatalError("Invalid categories initial plist file")
            }
            
            category.name = NSLocalizedString(name, comment: "")
            category.uid = UUID()
            do {
                try self.context.save()
            } catch {
                print(CoreDataError.saveContextError)
            }
        }
        
    }
}
