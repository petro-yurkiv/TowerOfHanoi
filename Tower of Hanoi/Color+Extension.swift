//
//  Color+Extension.swift
//  Tower of Hanoi
//
//  Created by Petro Yurkiv on 07.06.2024.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        let red = Double(arc4random_uniform(256)) / 255.0
        let green = Double(arc4random_uniform(256)) / 255.0
        let blue = Double(arc4random_uniform(256)) / 255.0
        return Color(red: red, green: green, blue: blue)
    }

    static func generateUniqueColors(count: Int) -> [Color] {
        var colorSet = Set<Color>()
        
        while colorSet.count < count {
            let newColor = Color.random()
            colorSet.insert(newColor)
        }
        
        return Array(colorSet)
    }
}
