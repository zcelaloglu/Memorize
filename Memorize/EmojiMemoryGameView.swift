//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 10.02.2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @StateObject var viewModel = EmojiMemoryGame()
    
    var body: some View {
        VStack {
            Text(viewModel.currentTheme.name)
                .font(.title)
                .padding()
            
            Text("Score: \(viewModel.score)")
                .font(.title2)
                .foregroundColor(.gray)
            
            ScrollView {
                cards.animation(.default, value: viewModel.cards)
            }
            Button("New Game") {
                viewModel.newGame()
            }.padding().clipShape(Capsule())
            Spacer()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                VStack(spacing: 0) {
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }.onTapGesture {
                    viewModel.choose(card)
                }
            }
        }
        .foregroundColor(viewModel.currentTheme.color)
    }
}

struct ThemeButton: View {
    let text: String
    let symbol: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            VStack {
                Image(systemName: symbol)
                Text(text).font(.caption2)
            }
        })
    }}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1: 0)
    }
}

#Preview {
    EmojiMemoryGameView()
}
