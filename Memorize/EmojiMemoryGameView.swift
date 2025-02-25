//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 10.02.2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.currentTheme.name)
                .font(.title)
                .padding()
            
            ScoreView(game: viewModel.game)
            
            ScrollView {
                cards.animation(.default, value: viewModel.cards)
            }
            Button("New Game") {
                viewModel.newGame()
            }
            .padding()
            .clipShape(Capsule())
            Spacer()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                VStack(spacing: 0) {
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }.onTapGesture {
                    viewModel.choose(card)
                }
            }
        }
        .foregroundStyle(viewModel.currentTheme.color)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
