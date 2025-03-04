//
//  CardView.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 24.02.2025.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var card: MemoryGame<String>.Card
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let cornerRadius = CGFloat(12)
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let inset: CGFloat = 5
            static let opacity = 0.5
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    typealias Card = MemoryGame<String>.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(card: .init(content: "X", isFaceUp: true)).aspectRatio(4/3, contentMode: .fit)
                CardView(card: .init(content: "X", isFaceUp: false))
            }
            
            HStack {
                CardView(
                    card: .init(content: "This is very long string and I hope it fits", isFaceUp: true)
                )
                CardView(card: .init(content: "X", isMatched: true))
            }
        }
        .padding()
        .foregroundStyle(.green)
    }
}
