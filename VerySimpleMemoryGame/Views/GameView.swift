//
//  ContentView.swift
//  VerySimpleMemoryGame
//
//  Created by Andrew Vale on 30/12/24.
//

import SwiftUI

struct GameView: View {
    
    let contents:[String] = [
        "❤️",
        "🎂",
        "❤️",
        "💩",
        "💩",
        "🎂"
    ]
    
    @State var cards: [Card] = []
    
    @State var flippedCards: [Binding<Card>] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach($cards) { $card in
                    VStack {
                        Spacer()
                        ZStack {
                            CardView(isFlipped: $card.isFlipped, verified: $card.verified, content: $card.content, rotationAngle: $card.rotationAngle)
                                .onTapGesture {
                                    withAnimation {
                                        if card.verified == false {
                                            if card.isFlipped == false {
                                                flippedCards.append($card)
                                            } else {
                                                flippedCards.removeLast()
                                            }
                                            card.rotationAngle = card.isFlipped ? 0 : 180
                                            card.isFlipped.toggle()
                                        }
                                    }
                                }
                        }
                        .frame(width: 100, height: 200)
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .onChange(of: flippedCards.count) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if flippedCards.count == cards.count {
                    withAnimation(.easeInOut(duration: 0.5)){
                        initialState()
                    }
                    return
                }
                if flippedCards.count % 2 == 0 && flippedCards.count > 0{
                    let firstCard = flippedCards[flippedCards.count - 2].content.wrappedValue
                    let secondCard = flippedCards[flippedCards.count - 1].content.wrappedValue
                    if firstCard == secondCard{
                        flippedCards[flippedCards.count - 2].verified.wrappedValue = true
                        flippedCards[flippedCards.count - 1].verified.wrappedValue = true
                    } else {
                        withAnimation(.easeInOut(duration: 0.5)){
                            flippedCards[flippedCards.count - 2].isFlipped.wrappedValue = false
                            flippedCards[flippedCards.count - 2].rotationAngle.wrappedValue = 0
                            flippedCards[flippedCards.count - 1].isFlipped.wrappedValue = false
                            flippedCards[flippedCards.count - 1].rotationAngle.wrappedValue = 0
                            flippedCards.removeLast()
                            flippedCards.removeLast()
                        }
                    }
                }
            }
        }
        .onAppear {
            initialState()
        }
    }
    
    //MARK: - Game Logic
    func initialState() {
        flippedCards = []
        cards = []
        for idx in 0..<6 {
            cards.append(Card(content: contents[idx], isFlipped: false, verified: false))
        }
    }
}
