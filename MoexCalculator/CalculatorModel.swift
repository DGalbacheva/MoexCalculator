//
//  CalculatorModel.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 15.11.2024.
//

import Foundation

struct CalculatorModel {

    //1
    private(set) var currencyRates = CurrencyRates()
 
    //2
    mutating func setCurrencyRates(_ currencyRates: CurrencyRates) {
        self.currencyRates = currencyRates
    }
    
    //3
    func convert(_ source: CurrencyAmount, to target: Currency) -> Double {
        guard
            let sourceRate = currencyRates[source.currency],
            let targetRate = currencyRates[target]
        else { return 0 }
        
        if targetRate.isZero {
            return 0
        } else {
            return source.amount * sourceRate / targetRate
        }
    }
}
