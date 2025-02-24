//
//  CardView.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 24.02.2025.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(card.isFaceUp ? .white : .orange)
            .strokeBorder(lineWidth: 2)
            .overlay {
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .opacity(card.isFaceUp ? 1 : 0)
            }
            .opacity(card.isFaceUp ? 1 : 0)
    }
}
