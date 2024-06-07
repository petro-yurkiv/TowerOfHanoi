//
//  ContentView.swift
//  Tower of Hanoi
//
//  Created by Petro Yurkiv on 07.06.2024.
//

import SwiftUI

struct ContentView: View {
    var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Tower of hanoi")
        }
        .padding()
        .onAppear(perform: {
            viewModel.main(n: 4)
        })
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
