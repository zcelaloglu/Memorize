//
//  ThemeButton.swift
//  Memorize
//
//  Created by Zafer CELALOGLU on 24.02.2025.
//

import SwiftUI

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
