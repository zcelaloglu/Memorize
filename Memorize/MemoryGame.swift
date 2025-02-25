//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 12.02.2025.
//

import Foundation

class MemoryGame<CardContent>: ObservableObject where CardContent: Equatable {
    @Published private(set) var cards: [Card]
    @Published var score = 0
    private var faceUpCardIndex: Int?
    
    private(set) var firstFaceUpCard: Card?
    private(set) var secondFaceUpCard: Card?
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        shuffle()
    }
    
    func choose(_ card: Card) {
        guard !card.isFaceUp && !card.isMatched else { return }
        card.isFaceUp = true
        
        if firstFaceUpCard == nil {
            firstFaceUpCard = card
        } else if secondFaceUpCard == nil {
            secondFaceUpCard = card
        } else {
            if firstFaceUpCard == secondFaceUpCard {
                firstFaceUpCard?.isMatched = true
                secondFaceUpCard?.isMatched = true
                score += 2
            } else {
                firstFaceUpCard?.isFaceUp = false
                secondFaceUpCard?.isFaceUp = false
                score -= 1
            }
            firstFaceUpCard = card
            secondFaceUpCard = nil
        }
    }
    
    func shuffle() {
        cards.shuffle()
    }
    
    class Card: ObservableObject, Equatable, Identifiable, CustomDebugStringConvertible {
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up": "down") \(isMatched ? " matched" : "")"
        }
        
        @Published var isFaceUp: Bool = false
        @Published var isMatched: Bool = false
        
        var hasBeenSeen = false
        let content: CardContent
        
        init(content: CardContent) {
            self.content = content
        }
        
        var id: CardContent { content }
        
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            lhs.id == rhs.id
        }
    
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
