//
//  ContentView.swift
//  Tower of Hanoi
//
//  Created by Petro Yurkiv on 07.06.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var diskCount: Int = 3
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                towers(geometry)
                
                Spacer()
                
                buttons
                    .padding(.bottom, 24.0)
            }
        }
        .padding(.horizontal, 16.0)
    }
    
    private func towers(_ geometry: GeometryProxy) -> some View {
        HStack {
            ForEach(0..<3, id: \.self) { index in
                Tower(disks: viewModel.towers[index])
                    .frame(width: towerWidth(geometry))
            }
        }
        .frame(height: 200.0)
    }
    
    private var buttons: some View {
        HStack {
            button("+") {
                if diskCount < 5 {
                    diskCount += 1
                    viewModel.resetDisks(diskCount)
                }
            }
            
            button("Start") {
                viewModel.main(n: diskCount)
            }
            
            button("-") {
                if diskCount > 0 {
                    diskCount -= 1
                    viewModel.resetDisks(diskCount)
                }
            }
        }
    }
    
    private func button(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 20.0))
                .foregroundColor(.white)
                .padding(.vertical, 8.0)
                .frame(width: 100)
                .background(Color.red)
                .cornerRadius(8.0)
        }
    }
    
    private func towerWidth(_ geometry: GeometryProxy) -> CGFloat {
        (geometry.size.width / 3) - 16.0
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
