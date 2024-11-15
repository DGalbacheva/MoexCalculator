//
//  Currency.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 15.11.2024.
//

import Foundation

// The Currency type defines the codes of four currencies: ruble, yuan, lev, euro and US dollar.
// Used wherever working with currencies is required.
// Implements the Identifiable protocol to enable the currency code selector to work in SwiftUI.
enum Currency: String, CaseIterable, Identifiable {
    
    // Коды валют
    case RUR
    case CNY
    case BGN
    case EUR
    case USD
    
    
    // The ID property is needed to implement the Identifiable protocol.
    // It defines a unique identifier for an object of that type.
    // Here Self means an ID of the Currency type, and self is one of the currency code values.
    // That is, the ID takes one of the values: RUR, CNY, BGN, EUR, or USD.
    var id: Self { self }
    
    // Emoji with flags of issuing countries
    var flag: String {
        switch self {
        case .RUR: return "🇷🇺"
        case .CNY: return "🇨🇳"
        case .BGN: return "🇧🇬"
        case .EUR: return "🇪🇺"
        case .USD: return "🇺🇸"
        
        }
    }
}

// Type for storing exchange rates
typealias CurrencyRates = [Currency: Double]

// The type that is used for currency conversion
struct CurrencyAmount {
    let currency: Currency
    let amount: Double
}
