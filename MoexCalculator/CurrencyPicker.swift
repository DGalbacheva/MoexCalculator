//
//  CurrencyPicker.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 16.11.2024.
//

import SwiftUI

struct CurrencyPicker: View {

    // Binding for a currency, which helps to read and write its value
    @Binding var currency: Currency
    
    // A function that is called when a currency is selected from the list
    let onChange: (Currency) -> Void
    
    var body: some View {
        
        // Picker - SwiftUI element for selecting a value from a list
        Picker("", selection: $currency) {
                        
            // ForEach - a SwiftUI element that generates a set of View
            // from a collection of values ​​with unique identifiers
            ForEach(Currency.allCases) { currency in
                Text(currency.rawValue.uppercased())
            }
        }
        // Sets the Picker style to "wheel" or "drum"
        .pickerStyle(.wheel)
        
        // Defines a function that is called when a new value is selected
        .onChange(of: currency, perform: onChange)
    }
}

// Structure that defines how a component is displayed in the preview panel
struct CurrencyPicker_Previews: PreviewProvider {
    
    static let currencyBinding = Binding<Currency>(
        get: { .RUR },
        set: { _ = $0 }
    )
    
    static var previews: some View {
        CurrencyPicker(currency: currencyBinding, onChange: { _ in })
    }
}
