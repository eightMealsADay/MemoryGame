//
//  wyj_MemorizeApp.swift
//  wyj-Memorize
//
//  Created by admin on 2024/10/11.
//

import SwiftUI

@main
struct wyj_MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
