//
//  MoexDataLoader.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 17.11.2024.
//

import Combine
import Foundation

/// Downloader of current exchange rates with the site Moex
final class MoexDataLoader {
    
    private static let endpoint = URL(string: "http://iss.moex.com/iss/statistics/engines/currency/markets/selt/rates.json?iss.meta=off")!
    
    func fetch(_ endpoint: URL = endpoint) -> AnyPublisher<CurrencyRates, Error> {
        
        URLSession.shared.dataTaskPublisher(for: endpoint)
            .map { $0.data }
            .decode(type: MoexQuote.self, decoder: JSONDecoder())
            .map { $0.currencyRates }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

/// A structure in which data from the Moexi site is decoded
struct MoexQuote: Decodable {
    let wap_rates: RawQuotes
}

/// A currencyRates calculated property that
/// converts the raw data into a dictionary of type CurrencyRates
extension MoexQuote {
    
    var currencyRates: CurrencyRates {

        // Initializable output dictionary. Ruble to ruble exchange rate is always equal to 1.
        var result: CurrencyRates = [.RUR: 1.0]
        
        // We find field indexes with currency name and quote in the columns array
        guard
            let currencyNameIndex = wap_rates.columns.map ({ $0.lowercased() }).firstIndex(of: "shortname"),
            let priceIndex = wap_rates.columns.map ({ $0.lowercased() }).firstIndex(of: "price")
        else { return result }
      
        // Iterate over arrays of attributes for each currency
        wap_rates.data.forEach { quoteArray in

            // If the name of the currency and quote is in an array,
            // convert them to the required type and save.
            guard
                quoteArray.indices.contains(currencyNameIndex),
                quoteArray.indices.contains(priceIndex),
                let rate = Double(quoteArray[priceIndex]),
                let currency = Currency(rawValue: String(quoteArray[currencyNameIndex].prefix(3)).uppercased())
            else { return }

            result[currency] = rate
        }

        return result
    }
}

/// A structure that decodes raw data into string arrays
struct RawQuotes: Decodable {
    
    // Decodeable fields
    enum CodingKeys: String, CodingKey {
        case columns, data
    }
    
    // Currency attribute field names
    let columns: [String]
    
    // Massive attribute currency
    let data: [[String]]
    
    init(from decoder: Decoder) throws {
        
        // Decodable columns attribute in string array
        let container = try decoder.container(keyedBy: CodingKeys.self)
        columns = try container.decode([String].self, forKey: .columns)
        
        var result = [[String]]()
        var arraysContainer = try container.nestedUnkeyedContainer(forKey: .data)
        
        // The data attribute containing [Any] arrays requires processing
        // special function for converting [Any] to [String]
        while !arraysContainer.isAtEnd {
            var singleArrayContainer = try arraysContainer.nestedUnkeyedContainer()
            let array = singleArrayContainer.decode(fromArray: &singleArrayContainer)
            result.append(array)
        }
        
        data = result
    }
}

/// Utility function converting [Any] to [String].
/// UnkeyedDecodingContainer allows decoding array values.
extension UnkeyedDecodingContainer {
    
    func decode(fromArray container: inout UnkeyedDecodingContainer) -> [String] {
        
        // Initializable output array
        var result = [String]()
        
        // Iterate over the values ​​of the input array in a loop
        while !container.isAtEnd {
            
            // Values ​​of type String are recorded as they are
            if let value = try? container.decode(String.self) {
                result.append(value)
                
            // Values ​​of type Int can be converted to a string
            } else if let value = try? container.decode(Int.self) {
                result.append("\(value)")
                
            // Values ​​of type Double can be converted to a string
            } else if let value = try? container.decode(Double.self) {
                result.append("\(value)")
            }
        }
        return result
    }
}
