//
//  ViewModel.swift
//  Tower of Hanoi
//
//  Created by Petro Yurkiv on 07.06.2024.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var towers: [[Int]] = [[], [], []]
    
    init() {
        resetDisks(3)
    }
    
    func resetDisks(_ count: Int) {
        towers = [Array(1...count), [], []]
    }
    
    func moveDisk(from: Int, to: Int) {
        if let disk = towers[from].last {
            towers[from].removeLast()
            towers[to].append(disk)
        }
        print("towers \(towers)")
    }
    
    private func hanoi(n: Int, fromRod: Int, toRod: Int, auxRod: Int) {
        if n == 1 {
            moveDisk(from: fromRod, to: toRod)
            return
        }
        
        hanoi(n: n - 1, fromRod: fromRod, toRod: auxRod, auxRod: toRod)
        moveDisk(from: fromRod, to: toRod)
        hanoi(n: n - 1, fromRod: auxRod, toRod: toRod, auxRod: fromRod)
    }

    func main(n: Int) {
        if n > 0 {
            resetDisks(n)
            hanoi(n: n, fromRod: 0, toRod: 2, auxRod: 1)
        } else {
            print("Number of disks must be greater than 0.")
        }
    }
}
