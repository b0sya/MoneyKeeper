enum Currency: String {
    case RUB = "₽"
    case USD = "$"
    case EUR = "€"
    
    static let stringArray = [RUB.rawValue, USD.rawValue, EUR.rawValue]
    
    var bankCode: String {
        switch self {
        case .EUR:
            return "EUR"
        case .RUB:
            return "RUB"
        case .USD:
            return "USD"
        }
    }
}
