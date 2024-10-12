//
//  EmojiMemoryGameView.swift
//  wyj-Memorize
//
//  Created by admin on 2024/10/11.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let emojis=["👻","😈","🐷","🐍","👀","🧙🏻‍♀️","🌵","🌈","❤️","🧡","💛","💚","🩵","💜"]
        
    var body: some View {
        ScrollView{
            cards.animation(.default,value: viewModel.cards)
        }
        Button("Shuffle"){
            viewModel.shuffle()
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns:[GridItem(.adaptive(minimum:90),spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3,contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
     
//    var cardCountAdjusters: some View{
//        HStack{
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
//    
//    func cardCountAdjuster(by offset: Int,symnol:String) -> some View{
//        Button(action:{
//            cardCount += offset
//        },label:{
//            Image(systemName:symnol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    
//    var cardRemover: some View{
//        cardCountAdjuster(by: -1,symnol: "rectangle.stack.badge.minus.fill")
//    }
//    
//    var cardAdder: some View{
//        cardCountAdjuster(by: +1,symnol: "rectangle.stack.badge.plus.fill")
//    }
}

struct CardView: View{
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card){
        self.card=card
    }
    
    var body:some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius:12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth:3)
                Text(card.content)
                    .font(.system(size: 50))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill().opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
    }
}

#Preview{
    EmojiMemoryGameView(viewModel:EmojiMemoryGame())
}
