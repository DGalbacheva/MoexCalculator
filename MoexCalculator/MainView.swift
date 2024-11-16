//
//  MainView.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 16.11.2024.
//

import SwiftUI

struct MainView: View {
    
    // Analogous to ObservedObject. Created in the parent object
    @EnvironmentObject var viewModel: CalculatorViewModel
    
    var body: some View {
        
        // Selecting a state and drawing the View depending on the state
        switch viewModel.state {
            
        // Loading indicator
        case .loading:
            ProgressView()
            
        // Screen that is displayed when there is an error: emoji and text
        case .error:
            VStack {
                Text("🤷‍♂️")
                    .font(.system(size: 100))
                    .padding()
                Text("Что-то пошло не так.\n Пожалуйста, попробуйте позже.")
                    .font(.body)
            }
            .multilineTextAlignment(.center)
        
        // The calculator screen that appears when the data has been successfully loaded
        case .content:
            CalculatorView()
            
        }
    }
}

#Preview {
    MainView()
}
