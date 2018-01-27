//
//  ViewController.swift
//  Concentration
//
//  Created by Ryan Ingram on 1/20/18.
//  Copyright © 2018 Ryan Ingram. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: ((cardButtons.count + 1) / 2))

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var backgroundView: UIView!
    
    var emojiChoices = [String]()
    
    var emoji = [Int:String]()
    
    var currentTheme = Theme(cardColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), backgroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), themeEmojis: ["❄️","⛄️","🏂","🌨","🎄","🎅🏻","🎁","🍭","🍬","🧝‍♂️"])
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.changeScore()
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print ("Chosen card not in cardButtons")
        }
        updateFlipCount()
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.newGame()
        game.shuffleCards()
        pickTheme()
        updateViewFromModel()
        updateFlipCount()
    }
    
    func updateFlipCount(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : currentTheme.cardColor
            }
        }
    }
    
    func pickTheme() {
        //Create a dictionary of Themes
        var availableThemes = [String: Theme]()
        availableThemes["Halloween"] = Theme(cardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), themeEmojis: ["🦇","🙀","😱","😈","🎃","👻","🍭","🍬","🍎","👺"])
        availableThemes["Winter"] = Theme(cardColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), themeEmojis: ["❄️","⛄️","🏂","🌨","🎄","🎅🏻","🎁","🍭","🍬","🧝‍♂️"])
        
        currentTheme = availableThemes["Winter"]!
        backgroundView.backgroundColor = availableThemes["Winter"]!.backgroundColor
        emojiChoices = availableThemes["Winter"]!.themeEmojis
        
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
            return emoji[card.identifier] ?? "?"
    }
    
}

