//
//  StorageProvider.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 13.03.2021.
//

import Foundation

enum StorageProviderError: Error {
    case fetchDataError(String)
    case parseDataError(String)
    case saveDataError(String)
}

typealias StorageProvider = StorageProviderOutput & StorageProviderInput

protocol StorageProviderOutput {
    
    typealias FetchAccountsOutput = Result<[FAccount], StorageProviderError>
    typealias FetchCategoriesOutput = Result<[FCategory], StorageProviderError>
    typealias FetchTransactionsOutput = Result<[FTransaction], StorageProviderError>
    
    func fetchAccounts(completion: ParameterClosure<FetchAccountsOutput>?)
    func fetchCategories(direction: DirectionType, completion: ParameterClosure<FetchCategoriesOutput>?)
}

protocol StorageProviderInput {
    
    typealias SeveAccountOutput = Result<FAccount, StorageProviderError>
    typealias SaveTransactionOutput = Result<FTransaction, StorageProviderError>
    typealias SaveCategoryOutput = Result<FCategory, StorageProviderError>
    
    func addAccount(
        uid: String,
        name: String,
        balance: Double,
        completion: ParameterClosure<SeveAccountOutput>?
    )
    func addTransaction(data: AddTransactionFormData, completion: ParameterClosure<SaveTransactionOutput>?)
}
