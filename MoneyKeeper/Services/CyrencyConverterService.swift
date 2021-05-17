//
//  File.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 06.05.2021.
//

import Foundation
import Alamofire

struct ExchangeRateResult: Decodable {
    let conversion_rates: Rates
}

struct Rates: Decodable {
    let RUB: Double?
}

final class CurrencyConverterService {
//    private let baseUrl = "http://api.exchangeratesapi.io/v1/"
    private let baseUrl = "https://v6.exchangerate-api.com/v6/"
//    private let apiKey = "29b214894aeb873bc104ac21b8016f3a"
    private let apiKey = "8ee9c35dbe7eaa1c3699a812"
        
    typealias ExchangeRateCallback = ParameterClosure<Result<ExchangeRateResult, Error>>
    
    func exchangeRateToRubFor(currency: Currency, callback: ExchangeRateCallback?) {
//        let params: [String: String] = [
//            "access_key": apiKey,
//            "base": "RUB"
//        ]
        
        let request = AF.request(baseUrl + apiKey + "/latest/" + currency.bankCode,
                                 method: .get)
        
        request.responseData { result in
            
            if let err = result.error {
                callback?(.failure(err))
                return
            }
            
            guard let data = result.data else {
                let err = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                callback?(.failure(err))
                return
            }
            
            do {
                let res = try JSONDecoder().decode(ExchangeRateResult.self, from: data)
                callback?(.success(res))
            }
            catch {
                callback?(.failure(error))
            }
        }
    }
}
