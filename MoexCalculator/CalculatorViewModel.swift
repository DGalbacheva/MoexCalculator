//
//  CalculatorViewModel.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 15.11.2024.
//

import Foundation
import Combine

final class CalculatorViewModel: ObservableObject {     // 1

    private var model = CalculatorModel()               // 2
    
    enum State {
        case loading    // data is loading
        case content    // data loaded
        case error      // error loading data
    }
    
    @Published var state: State = .content

    @Published var topCurrency: Currency = .CNY         // 3
    @Published var bottomCurrency: Currency = .RUR      // 4
        
    @Published var topAmount: Double = 0                // 5
    @Published var bottomAmount: Double = 0             // 6
    
    // Data loader
    private let loader: MoexDataLoader
    
    // Combine subscription storage
    private var subscriptions = Set<AnyCancellable>()
    
    // An initializer that accepts a bootloader variable
    init(with loader: MoexDataLoader = MoexDataLoader()) {
        self.loader = loader
        fetchData()
    }
    
    // A function that triggers a data request using the loader
    // and sets the state variable depending on
    //  from the download result
    private func fetchData() {
        loader.fetch().sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure = completion {
                    self.state = .error
                }
            },
            receiveValue: { [weak self] currencyRates in
                guard let self = self else { return }
                self.model.setCurrencyRates(currencyRates)
                self.state = .content
            })
        .store(in: &subscriptions)
    }
    
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

