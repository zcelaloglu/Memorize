//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 12.02.2025.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    private var faceUpCardIndex: Int? // Store the index of the face-up card
    
    private(set) var firstFaceUpCard: Card?
    private(set) var secondFaceUpCard: Card?
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        shuffle()
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched else {
            return
        }
        
        if let potentialMatchIndex = cards.indices.filter({ cards[$0].isFaceUp && !cards[$0].isMatched }).only {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 2
            } else if cards[chosenIndex].hasBeenSeen || cards[potentialMatchIndex].hasBeenSeen {
                score -= 1
            }
            cards[chosenIndex].isFaceUp = true
            cards[chosenIndex].hasBeenSeen = true
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            cards[chosenIndex].isFaceUp = true
            cards[chosenIndex].hasBeenSeen = true
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up": "down") \(isMatched ? " matched" : "")"
        }
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen = false
        let content: CardContent
        
        var id: String
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
