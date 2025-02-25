//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 12.02.2025.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themes: [Theme] = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧟‍♂️", "🦇"], numberOfPairs: Int.random(in: 6...8), color: .orange),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨"], numberOfPairs: Int.random(in: 6...8), color: .blue),
        Theme(name: "Fruits", emojis: ["🍎", "🍌", "🍒", "🍇", "🍉", "🥭", "🍍", "🍑", "🥝"], numberOfPairs: Int.random(in: 6...8), color: .red),
        Theme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥎"], numberOfPairs: Int.random(in: 6...8), color: .green),
        Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒"], numberOfPairs: Int.random(in: 6...8), color: .purple),
        Theme(name: "Faces", emojis: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊"], numberOfPairs: Int.random(in: 6...8), color: .yellow)
    ]
    
    @Published private var model: MemoryGame<String>!
    @Published private(set) var currentTheme: Theme!
    
    var score: Int {
        model.score
    }
    
    var game: MemoryGame<String> {
        model
    }
    
    init() {
        self.newGame()
    }
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let selectedEmojis = theme.emojis.shuffled().prefix(theme.numberOfPairs)
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { index in
            selectedEmojis[index]
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        let theme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
        currentTheme = theme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairs: Int
    let color: Color
}
