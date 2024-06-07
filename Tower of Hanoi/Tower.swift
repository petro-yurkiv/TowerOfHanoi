//
//  Tower.swift
//  Tower of Hanoi
//
//  Created by Petro Yurkiv on 07.06.2024.
//

import SwiftUI

struct Tower: View {
    var disks: [Int]
    
    var body: some View {
        ZStack {
            rod
            disksView
                .padding(.bottom, 24.0)
        }
    }
    
    private var rod: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .frame(width: 16.0)
            Rectangle()
                .frame(height: 16.0)
        }
    }
    
    private var disksView: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 8.0) {
                ForEach(disks, id: \.self) { disk in
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundStyle(.red)
                        .frame(height: 26.0)
                        .padding(.horizontal, CGFloat((5 - disk)) * 8)
                }
            }
        }
    }
}

#Preview {
    Tower(disks: [1, 2, 3, 4, 5])
}
