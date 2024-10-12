//
//  EmojiMemoryGame.swift
//  wyj-Memorize
//
//  Created by admin on 2024/10/11.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    private static let emojis = ["👻","😈","🐷","🐍","👀","🧙🏻‍♀️","🌵","🌈","❤️","🧡","💛","💚","🩵","💜"]
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 8){pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }else{
                return "out of cardcount range!"
            }
        }
    }
    
    @Published private(set) var model = createMemoryGame()
        
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
