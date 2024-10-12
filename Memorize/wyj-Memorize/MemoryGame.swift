//
//  Untitled.swift
//  wyj-Memorize
//
//  Created by admin on 2024/10/11.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory:(Int) -> CardContent){
        cards = []
        // numberOfPairsOfCardsn * 2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get{
            let faceUpCardIndices = cards.indices.filter{index in cards[index].isFaceUp}
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first:nil
        }
        
        set{
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    mutating func choose( _ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                }else{
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
//    private func index(of card:Card) -> Int? {
//        for index in cards.indices{
//            if cards[index].id == card.id{
//                return index
//            }
//        }
//        return nil
//    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
     
    struct Card: Equatable,Identifiable,CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up":"down") \(isMatched ? "matched":"")"
        }
    }
}


