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
            
            HStack { // 3
                
                VStack { // 4
                    Text(viewModel.topCurrency.flag) // 5
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text(viewModel.topCurrency.rawValue) // 6
                        .font(.title2)
                }
                .frame(height: 100)

                TextField("", value: $viewModel.topAmount, formatter: numberFormatter) // 7
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                    .minimumScaleFactor(0.5)
                    .keyboardType(.numberPad)
            }
            
            HStack {   // 8
                
                VStack { // 9
                    Text(viewModel.bottomCurrency.flag) // 10
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text(viewModel.bottomCurrency.rawValue) // 11
                        .font(.title2)
                }
                .frame(height: 100)

                TextField("", value: $viewModel.bottomAmount, formatter: numberFormatter) // 12
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                    .minimumScaleFactor(0.5)
                    .keyboardType(.numberPad)
            }
        }
    }
    
    var numberFormatter: NumberFormatter = { // 13
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.usesGroupingSeparator = false
        nf.maximumFractionDigits = 2
        return nf
    }()
}

struct CalculatorView_Previews: PreviewProvider { // 14
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel())
    }
}
