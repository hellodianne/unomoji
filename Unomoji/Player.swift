//
//  Player.swift
//  Unomoji
//
//  Created by Dianne Katrina Bronola on 5/23/16.
//  Copyright © 2016 Dianne Bronola. All rights reserved.
//
import Foundation

struct Player {
    
    var cardsOnHand: [Card]
    let name: String
    
    init(name: String, cardsOnHand:[Card]){
        self.name = name
        self.cardsOnHand = cardsOnHand
    }
    
    var currentCardsOnHand: [Card] {
        get {
            return cardsOnHand
        }
    }
    
    mutating func throwCard(cardtoThrow: Card) -> Card {
        //remove from CardsOnHand
        cardsOnHand.removeAtIndex(indexOf(cardtoThrow)!)
        return cardtoThrow
    }
    
    
    func count() -> Int {
        return cardsOnHand.count
    }
    
    
    mutating func pickCard(cardtoPick: Card) {
        //append card to cardsOnHand
        cardsOnHand.append(cardtoPick)
    }
    
    func isPlayable(card: CardView, cardShowing: Card) -> Bool {
        return card.card.color == cardShowing.color || card.card.emoji == cardShowing.emoji
    }
    
    
    func playableCards(cardShowing: Card) -> [Card]{
        //check all cards on hand, return only playable
        let playThisCards = cardsOnHand.filter({$0.color == cardShowing.color || $0.emoji == cardShowing.emoji})
        return playThisCards
    }
    
    
    
    //for removing cards
    func indexOf(card: Card) -> Int? {
        return cardsOnHand.indexOf() {$0.name == card.name}
    }
    
    mutating func removeCard(card: Card) {
        
        let cardIndex = indexOf(card)
        cardsOnHand.removeAtIndex(cardIndex!)
    }
    
}