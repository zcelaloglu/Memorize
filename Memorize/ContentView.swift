//
//  ContentView.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 10.02.2025.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "🎃", "🕷️", "😈", "😈", "💀","🕸️", "🎶", "🙀", "🦁", "😱", "🤖", "🍭"]
        
    var body: some View {
        VStack {
            title
            Spacer()
            ScrollView {
                cards
            }
            Spacer()
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
