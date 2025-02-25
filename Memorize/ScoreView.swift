//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 25.02.2025.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var game: MemoryGame<String>
 
    var body: some View {
        Text("Score: \(game.score)")
            .font(.title2)
            .foregroundColor(.gray)
    }
}
