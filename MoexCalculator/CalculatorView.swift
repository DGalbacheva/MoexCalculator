//
//  CalculatorView.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 16.11.2024.
//

import SwiftUI

struct CalculatorView: View {
    
    @ObservedObject var viewModel: CalculatorViewModel // 1
    
    var body: some View {
    
        List {  // 2
            
            CurrencyInput(
                currency: viewModel.topCurrency,
                amount: viewModel.topAmount,
                calculator: viewModel.setTopAmount)
            
            CurrencyInput(
                currency: viewModel.bottomCurrency,
                amount: viewModel.bottomAmount,
                calculator: viewModel.setBottomAmount)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider { // 14
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel())
    }
}
