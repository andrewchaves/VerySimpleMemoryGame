//
//  Card.swift
//  VerySimpleMemoryGame
//
//  Created by Andrew Vale on 30/12/24.
//
import Foundation

struct Card: Identifiable {
    var id = UUID()
    var content: String
    var isFlipped: Bool = false
    var rotationAngle: Double = 0
    var verified: Bool = false
}
