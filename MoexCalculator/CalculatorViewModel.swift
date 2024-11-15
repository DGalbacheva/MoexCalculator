//
//  CalculatorViewModel.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 15.11.2024.
//

import Foundation

final class CalculatorViewModel: ObservableObject {     // 1

    private var model = CalculatorModel()               // 2

    @Published var topCurrency: Currency = .CNY         // 3
    @Published var bottomCurrency: Currency = .RUR      // 4
        
    @Published var topAmount: Double = 0                // 5
    @Published var bottomAmount: Double = 0             // 6
    
    func setTopAmount(_ amount: Double) {               // 7
        topAmount = amount
        updateBottomAmount()
    }
    
    func setBottomAmount(_ amount: Double) {            // 8
        bottomAmount = amount
        updateTopAmount()
    }
    
    func updateBottomAmount() {                         // 9
        let topAmount = CurrencyAmount(currency: topCurrency, amount: topAmount)
        bottomAmount = model.convert(topAmount, to: bottomCurrency)
    }
    
    func updateTopAmount() {                            // 10
        let bottomAmount = CurrencyAmount(currency: bottomCurrency, amount: bottomAmount)
        topAmount = model.convert(bottomAmount, to: topCurrency)
    }
}

