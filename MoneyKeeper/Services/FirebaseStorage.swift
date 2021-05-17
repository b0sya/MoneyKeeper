//
//  FirebaseStorage.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 13.03.2021.
//

import Foundation
import FirebaseFirestore

final class FirebaseStorage: StorageProvider {
    static let instance = FirebaseStorage()
    
    private let db: Firestore
    
    private init() {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let db = Firestore.firestore()
        db.settings = settings
        
        self.db = db
        loadInitialCategoriesIfNeeded()
    }
    
    private func loadInitialCategoriesIfNeeded() {
//        guard !UserDefaults.standard.bool(forKey: Keys.initialCategoriesWasLoaded) else {
//            return
//        }
//                
//        guard let pathToFile = Bundle.main.path(forResource: "categoriesInitial", ofType: "plist") else { return }
//        
//        guard let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
//        for dictionary in dataArray {
//            
//            let dict = dictionary as! NSDictionary
//            
//            guard let name = dict["name"] as? String else {
//                fatalError("Invalid categories initial plist file")
//            }
//            
//            addCategory(name: name, direction: .cost, completion: nil)
//        }
        
    }
    
    //MARK: Fetch methods
    func fetchAccounts(completion: ParameterClosure<FetchAccountsOutput>?) {
        db.collection(FAccount.collectionKey).getDocuments { snapshot, error in
            if let error = error {
                completion?(.failure(.fetchDataError("Fetch accounts failed: \(error.localizedDescription)")))
                return
            }
            guard let accounts = snapshot?.documents.compactMap({ FAccount(from: $0.data()) }) else {
                completion?(.failure(.parseDataError("Parse accounts data failed")))
                return
            }
            
            completion?(.success(accounts))
        }
    }
    
    func fetchCategories(direction: DirectionType, completion: ParameterClosure<FetchCategoriesOutput>?) {
        let query = db.collection(FCategory.collectionKey)
            .whereField(FCategory.Keys.directionId.rawValue,
                        in: [direction.rawValue])
        
        query.getDocuments { snapshot, error in
            if let error = error {
                completion?(.failure(.fetchDataError("Fetch categories failed: \(error.localizedDescription)")))
                return
            }
            
            guard let accounts = snapshot?.documents.compactMap({ FCategory(from: $0.data()) }) else {
                completion?(.failure(.parseDataError("Parse categories data failed")))
                return
            }
            
            completion?(.success(accounts))
        }
    }
    
    func fetchTransactions(for account: FAccount, completion: ParameterClosure<FetchTransactionsOutput>?) {
        let query = db.collection(FTransaction.collectionKey).whereField(FTransaction.Keys.relatedAccountId, in: [account.uid])
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                completion?(.failure(.fetchDataError("Failed to load transactions for account \(account.name): \(error.localizedDescription)")))
                return
            }
            
            guard let transactions = snapshot?.documents.compactMap({ FTransaction(from: $0.data()) }) else {
                completion?(.failure(.parseDataError("Parse transactions data failed")))
                return
            }
            
            completion?(.success(transactions))
            
        }
    }
    ///add fetch parent categories + fetch subcategories
    
    func fetchMainCategories(direction: DirectionType, completion: ParameterClosure<FetchCategoriesOutput>?) {
        let query = db.collection(FCategory.collectionKey)
            .whereField(FCategory.Keys.parentCategoryId.rawValue,
                        isEqualTo: "")
            .whereField(FCategory.Keys.directionId.rawValue,
                        in: [direction.rawValue])
        
        query.getDocuments { snapshot, error in
            if let error = error {
                completion?(.failure(.fetchDataError("Fetch categories failed: \(error.localizedDescription)")))
                return
            }
            
            guard let accounts = snapshot?.documents.compactMap({ FCategory(from: $0.data()) }) else {
                completion?(.failure(.parseDataError("Parse categories data failed")))
                return
            }
            
            completion?(.success(accounts))
        }
    }
    
    func fetchSubcategories(for category: FCategory, completion: ParameterClosure<FetchCategoriesOutput>?) {
        db.collection(FCategory.collectionKey)
            .whereField(FCategory.Keys.parentCategoryId.rawValue, isEqualTo: category.uid).getDocuments { snapshot, error in
                if let error = error {
                    completion?(.failure(.fetchDataError("Fetch categories failed: \(error.localizedDescription)")))
                    return
                }
                
                guard let accounts = snapshot?.documents.compactMap({ FCategory(from: $0.data()) }) else {
                    completion?(.failure(.parseDataError("Parse categories data failed")))
                    return
                }
                
                completion?(.success(accounts))
            }
    }
    
    func fetchTransactions(for period: Period, completion: ParameterClosure<FetchTransactionsOutput>?) {
        let query = db.collection(FTransaction.collectionKey)
            .whereField(FTransaction.Keys.date, isGreaterThanOrEqualTo: period.start)
            .whereField(FTransaction.Keys.date, isLessThanOrEqualTo: period.end)
        
        db.collection(FTransaction.collectionKey)
        
        query.getDocuments { snapshot, error in
            if let error = error {
                completion?(.failure(.fetchDataError("Failed to load transactions for period \(period.start) \(period.end): \(error.localizedDescription)")))
                return
            }
            
            guard let transactions = snapshot?.documents.compactMap({ FTransaction(from: $0.data()) }) else {
                completion?(.failure(.parseDataError("Parse transactions data failed")))
                return
            }
            
//            guard let transactionsData = snapshot?.documents.compactMap({
//                let trans = FTransaction(from: $0.data())
//
//                guard let parentId = trans?.relatedCategory.parentCategoryId, !parentId.isEmpty else {
//                    return TransactionsData(transaction: trans, mainCategory: nil)
//                }
//
//                db.collection(FCategory.collectionKey).document(parentId).getDocument { snapshot, error in
//                    if let error = error {
//                        return
//                    }
//
//                    guard let data = snapshot?.data(), let category = FCategory(from: data) else {
//                        return TransactionsData(transaction: trans, mainCategory: nil)
//                    }
//
//                    return TransactionsData(transaction: trans, mainCategory: category)
//                }
//            }) else {
//                completion?(.failure(.parseDataError("Parse transactions data failed")))
//                return
//            }
            
            completion?(.success(transactions))
        }
    }
    
    //MARK: Save methods
    func addAccount(
        uid: String,
        name: String,
        balance: Double,
        completion: ParameterClosure<SeveAccountOutput>?
    ) {
        let newAccount = FAccount(uid: uid, name: name, balance: balance)
        
        db.collection(FAccount.collectionKey).document(newAccount.uid).setData(newAccount.dictionaryRepresentation) { error in
            if let error = error {
                completion?(.failure(.saveDataError("Failed to add new account: \(error.localizedDescription)")))
                return
            }
            
            completion?(.success(newAccount))
        }
    }
    
    func addTransaction(data: AddTransactionFormData, completion: ParameterClosure<SaveTransactionOutput>?) {

        let transaction = FTransaction(uid: data.uid,
                                       mainAmount: data.mainAmount,
                                       presentAmount: data.presentedAmount,
                                       currency: data.currency,
                                       date: data.date,
                                       note: data.description,
                                       direction: data.direction,
                                       relatedAccount: data.account,
                                       relatedCategory: data.category)
        
        db.collection(FTransaction.collectionKey).document(transaction.uid).setData(transaction.dictionaryRepresentation) { error in
            if let error = error {
                completion?(.failure(.saveDataError("Faild to add new transaction: \(error.localizedDescription)")))
                return
            }
            
            let reference = self.db.collection(FAccount.collectionKey).document(data.account.uid)
            
            if transaction.direction == .cost {
                reference.updateData([FAccount.Keys.balance: FieldValue.increment(-transaction.mainAmount)])
            }
            else {
                reference.updateData([FAccount.Keys.balance: FieldValue.increment(transaction.mainAmount)])
            }
                        
            completion?(.success(transaction))
        }
    }
    
    func addCategory(name: String, direction: DirectionType, parent: FCategory?, completion: ParameterClosure<SaveCategoryOutput>?) {
        let category = FCategory(uid: UUID().uuidString,
                                 name: name,
                                 direction: direction,
                                 parentCategoryId: parent?.uid)
        
        if let parent = parent {
            db.collection(FCategory.collectionKey).document(parent.uid).updateData([
                FCategory.Keys.subcategoryIds.rawValue: FieldValue.arrayUnion([category.uid])
            ])
        }
        
        db.collection(FCategory.collectionKey).document(category.uid).setData(category.dictionaryRepresentation) { error in
            if let error = error {
                completion?(.failure(.saveDataError("Faild to add new category: \(error.localizedDescription)")))
            }
            
            completion?(.success(category))
        }
    }
    
    //MARK: Remove methods
    
    func remove(account: FAccount, transactions: [FTransaction], completion: ParameterClosure<RemoveAccountOutput>?) {
        db.collection(FAccount.collectionKey).document(account.uid).delete { error in
            if let error = error {
                completion?(.failure(.removeDataError("Failed to remove account: \(error.localizedDescription)")))
                return
            }
            
            transactions.forEach {
                self.db.collection(FTransaction.collectionKey).document($0.uid).delete()
            }
            completion?(.success(Void()))
        }
    }
}
