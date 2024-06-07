//
//  ContentView.swift
//  Tower of Hanoi
//
//  Created by Petro Yurkiv on 07.06.2024.
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var diskCount: Int = 3
    @State private var colors: [Color] = [.black, .black, .black]
    @State private var positions: [CGSize] = Array(repeating: .zero, count: 3)
    @State private var towersHeight = [CGFloat]()
    @State private var geometrySize: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                towers(geometry)
                    .overlay(alignment: .bottom) {
                        HStack {
                            disks(geometry)
                            Spacer()
                        }
                        .padding(.bottom, 24.0)
                    }
                
                Spacer()
                
                buttons {
                    if diskCount < 5 {
                        diskCount += 1
                        update()
                    }
                } startAction: {
                    update()
                    startHanoiAnimation(diskCount: diskCount, geometry: geometry)
                } minAction: {
                    if diskCount > 1 {
                        diskCount -= 1
                        update()
                    }
                }
                .padding(.bottom, 24.0)
            }
            .padding(.horizontal, 16.0)
            .background(.white)
            .onAppear {
                colors = Color.generateUniqueColors(count: diskCount)
                towersHeight = [CGFloat(diskCount) * 34.0, 0.0, 0.0]
                geometrySize = geometry.size
            }
            .onChange(of: geometry.size) { newSize in
                if newSize != geometrySize {
                    geometrySize = newSize
                    updatePositions(for: newSize)
                }
            }
        }
    }
    
    private func updatePositions(for size: CGSize) {
        positions = Array(repeating: .zero, count: diskCount)
    }
    
    private func update() {
        viewModel.resetDisks(diskCount)
        updatePositions(for: geometrySize)
        towersHeight = [CGFloat(diskCount) * 34.0, 0.0, 0.0]
        colors = Color.generateUniqueColors(count: diskCount)
    }
    
    private func startHanoiAnimation(diskCount: Int, geometry: GeometryProxy) {
        viewModel.main(n: diskCount)
        animateMoves(viewModel.moves, geometry: geometry)
    }
}

private extension ContentView {
    //views
    
    private func towers(_ geometry: GeometryProxy) -> some View {
        HStack(spacing: 8.0) {
            ForEach(0..<3, id: \.self) { index in
                tower(geometry)
            }
        }
        .frame(height: 200.0)
    }
    
    func tower(_ geometry: GeometryProxy) -> some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .frame(width: 16.0)
                .foregroundColor(.black)
            Rectangle()
                .frame(width: towerWidth(geometry), height: 16.0)
                .foregroundColor(.black)
        }
    }
    
    private func disks(_ geometry: GeometryProxy) -> some View {
        VStack(alignment: .center, spacing: 8.0) {
            ForEach(0..<diskCount, id: \.self) { disk in
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(.black, lineWidth: 1.0)
                    .fill(colors[disk])
                    .frame(width: towerWidth(geometry) - CGFloat((diskCount - 1 - disk) * 8), height: 26.0)
                    .offset(x: positions[disk].width, y: positions[disk].height)
                    .animation(.easeInOut(duration: 0.2), value: positions)
            }
        }
    }
    
    private func buttons(plusAction: @escaping () -> Void, startAction: @escaping () -> Void, minAction: @escaping () -> Void) -> some View {
        HStack {
            button("+") {
                plusAction()
            }
            
            button("Start") {
                startAction()
            }
            
            button("-") {
                minAction()
            }
        }
    }
    
    private func button(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 20.0))
                .foregroundColor(.black)
                .padding(.vertical, 8.0)
                .frame(width: 100)
                .background(.white)
                .cornerRadius(8.0)
                .overlay {
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(.black, lineWidth: 1.0)
                }
        }
    }
    
    private func towerWidth(_ geometry: GeometryProxy) -> CGFloat {
        return (geometry.size.width / 3) - 16.0
    }
}

private extension ContentView {
    //animation
    
    private func animateMoves(_ moves: [(disk: Int, from: Int, to: Int)], geometry: GeometryProxy) {
        for (index, move) in moves.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3) {
                print("animation start")
                animateMove(disk: move.disk, from: move.from, to: move.to, geometry: geometry)
            }
        }
    }
    
    private func animateMove(disk: Int, from: Int, to: Int, geometry: GeometryProxy) {
        towersHeight[from] = towersHeight[from] - 34.0
        withAnimation(.easeInOut(duration: 0.1)) {
            positions[disk - 1] = CGSize(width: positions[disk - 1].width, height: -200.0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            towersHeight[to] = towersHeight[to] + 34.0
            withAnimation(.easeInOut(duration: 0.1)) {
                let xOffset = (towerWidth(geometry) + 8) * CGFloat(to - from)
                positions[disk - 1] = CGSize(width: positions[disk - 1].width + xOffset, height: -200.0)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    positions[disk - 1] = CGSize(width: positions[disk - 1].width, height: 34.0 * CGFloat(diskCount) - towersHeight[to] - CGFloat(disk - 1) * 34.0)
                    print("animation finish")
                }
            }
        }
    }
}
