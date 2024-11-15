//
//  ContentView.swift
//  MoexCalculator
//
//  Created by Doroteya Galbacheva on 15.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State var color = Color.green
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
                .padding()
                .foregroundColor(color)
            Button("Click") {
                if color == .green  {
                    color = .orange
                } else {
                    color = .green
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
