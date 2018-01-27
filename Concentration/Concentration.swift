//
//  Concentration.swift
//  Concentration
//
//  Created by Ryan Ingram on 1/20/18.
//  Copyright © 2018 Ryan Ingram. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var score = 0
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func newGame() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
            cards[index].previouslySeen = false
            score = 0
            flipCount = 0
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or two cards
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].previouslySeen = true
                score -= 1
            }
        }
    }
    
    // return the number of cards flipped
    // and the current score
    func changeScore(){
        flipCount += 1
    }
    
    // Shuffle the cards
    func shuffleCards() {
        var tempCards = [Card]()
        for _ in cards.indices {
            let randomNumber = Int(arc4random_uniform(UInt32(cards.count)))
            tempCards.append(cards[randomNumber])
            cards.remove(at: randomNumber)
        }
        cards = tempCards
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
    }
    
}
