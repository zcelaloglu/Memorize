//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 10.02.2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
