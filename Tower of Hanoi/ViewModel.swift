//
//  ViewModel.swift
//  Tower of Hanoi
//
//  Created by Petro Yurkiv on 07.06.2024.
//

import Foundation

final class ViewModel {
    private func hanoi(n: Int, fromRod: String, toRod: String, auxRod: String) {
        if n == 1 {
            print("Move disk 1 from rod \(fromRod) to rod \(toRod)")
            return
        }
        
        hanoi(n: n - 1, fromRod: fromRod, toRod: auxRod, auxRod: toRod)
        print("Move disk \(n) from rod \(fromRod) to rod \(toRod)")
        hanoi(n: n - 1, fromRod: auxRod, toRod: toRod, auxRod: fromRod)
    }

    func main(n: Int) {
        if n > 0 {
            print("The sequence of moves to solve the Tower of Hanoi with \(n) disks is:")
            hanoi(n: n, fromRod: "A", toRod: "C", auxRod: "B")
        } else {
            print("Number of disks must be greater than 0.")
        }
    }
}
