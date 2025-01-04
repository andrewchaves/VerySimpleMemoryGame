//
//  CarView.swift
//  VerySimpleMemoryGame
//
//  Created by Andrew Vale on 02/01/25.
//
import SwiftUI

struct CardView: View {
    @Binding var isFlipped: Bool
    @Binding var verified: Bool
    @Binding var content: String
    @Binding var rotationAngle: Double
    
    var body: some View {
        ZStack {
            if isFlipped || verified {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
                Text(content)
                    .font(.headline)
                    .foregroundColor(.white)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                    Text("?")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
        }
        .rotation3DEffect(
            .degrees(rotationAngle),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5
        )
    }
}
