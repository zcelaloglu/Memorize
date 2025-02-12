//
//  ContentView.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 10.02.2025.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis: [String] = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧟‍♂️", "🦇", "🙀", "😱", "🧙‍♀️"]
    let animalEmojis: [String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁"]
    let fruitEmojis: [String] = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍑"]

    @State var emojis: [String] = []
    @State var themeColor: Color = .orange
        
    var body: some View {
        VStack {
            title
            Spacer(minLength: 30)
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
        .onAppear() {
            emojis = halloweenEmojis.shuffled()
        }
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    var themeButtons: some View {
        HStack(spacing: 30) {
            ThemeButton(text: "Halloween", symbol: "moon.stars.fill") {
                setupTheme(emojisSet: halloweenEmojis, color: .orange)
            }
            ThemeButton(text: "Animals", symbol: "pawprint.fill") {
                setupTheme(emojisSet: animalEmojis, color: .blue)
            }
            ThemeButton(text: "Fruits", symbol: "applelogo") {
                setupTheme(emojisSet: fruitEmojis, color: .green)
            }
        }
        .imageScale(.large)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(themeColor)
    }
    
    private func setupTheme(emojisSet: [String], color: Color) {
        emojis = (emojisSet + emojisSet).shuffled()
        themeColor = color
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
    let content: String
    @State var isFaceUp: Bool = false
    
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
