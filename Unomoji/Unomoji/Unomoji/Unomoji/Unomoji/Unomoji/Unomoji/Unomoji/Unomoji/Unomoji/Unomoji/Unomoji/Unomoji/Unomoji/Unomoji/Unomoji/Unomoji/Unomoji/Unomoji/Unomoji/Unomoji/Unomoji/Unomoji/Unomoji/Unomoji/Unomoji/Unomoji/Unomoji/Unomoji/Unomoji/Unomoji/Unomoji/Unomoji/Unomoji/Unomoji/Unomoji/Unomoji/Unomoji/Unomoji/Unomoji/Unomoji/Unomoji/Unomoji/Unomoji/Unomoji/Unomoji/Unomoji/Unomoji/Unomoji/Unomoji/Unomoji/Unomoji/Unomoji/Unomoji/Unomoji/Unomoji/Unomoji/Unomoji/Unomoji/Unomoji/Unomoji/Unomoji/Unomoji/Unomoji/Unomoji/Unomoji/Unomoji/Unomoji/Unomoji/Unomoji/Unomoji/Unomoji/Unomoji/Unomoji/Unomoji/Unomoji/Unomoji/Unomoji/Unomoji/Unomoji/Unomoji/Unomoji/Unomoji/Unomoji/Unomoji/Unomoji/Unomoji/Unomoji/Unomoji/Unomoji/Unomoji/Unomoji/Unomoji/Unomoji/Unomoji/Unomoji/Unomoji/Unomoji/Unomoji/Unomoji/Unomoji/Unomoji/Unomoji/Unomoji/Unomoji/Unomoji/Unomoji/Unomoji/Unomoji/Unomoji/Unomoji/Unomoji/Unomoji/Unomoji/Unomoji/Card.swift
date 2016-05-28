//
//  Card.swift
//  Unomoji
//
//  Created by Dianne Katrina Bronola on 5/23/16.
//  Copyright © 2016 Dianne Bronola. All rights reserved.
//
import UIKit

struct Card {
    
    let name: String
    let color: UIColor
    let emoji: String
    
    static let NameKey = "NameKey"
    static let ColorKey = "ColorKey"
    static let EmKey = "EmKey"
    
    init(dictionary: [String: AnyObject]) {
        
        self.name = dictionary[Card.NameKey] as! String
        self.color = dictionary[Card.ColorKey] as! UIColor
        self.emoji = dictionary[Card.EmKey] as! String
        
    }
}

extension Card {
    //card data
    static var deckOfCards: [Card] {
        
        var cardData  = [[String: AnyObject]]()
        var cardArray = [Card]()
        
        let green = UIColor(red:0.82, green:0.95, blue:0.65, alpha:1.0)
        let blue = UIColor(red:0.00, green:0.25, blue:0.50, alpha:1.0)
        let peach = UIColor(red:1.00, green:0.77, blue:0.55, alpha:1.0)
        let pink = UIColor(red:0.96, green:0.41, blue:0.57, alpha:1.0)
        let aqua = UIColor(red:0.38, green:0.65, blue:0.67, alpha:1.0)
        let yellow = UIColor(red:1.00, green:1.00, blue:0.00, alpha:1.0)
        
        let chicken = "🍗"
        let panda = "🐼"
        let oct = "🐙"
        let ayn = "👾"
        let mic = "🎤"
        let haha = "😁"
        let red = "👺"
        let camille = "🐫"
        let jetplane = "✈️"
        
        let colorArray: [UIColor] = [green, blue, peach, pink, aqua, yellow]
        let emojiArray: [String] = [chicken, panda, oct, ayn, mic, haha, red, camille, jetplane]
        
        for c in colorArray {
            for n in emojiArray {
                cardData.append([Card.NameKey: "\(c)\(n)", Card.ColorKey: c, Card.EmKey: "\(n)"])
            }
            
        }
        
        for d in cardData {
            cardArray.append(Card(dictionary: d))
        }
        
        return cardArray

        
        
    }
}




//Mark: Array extension for random card selection
extension Array {

    
    
    mutating func chooseOne() -> Element  {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        let a = self[index]
        self.removeAtIndex(index)
        return a
//        let index = []
//        let a = element[index]
//        return a
//        let a = self[Int(arc4random_uniform(UInt32(count)))]
//        self.removeElement(a)
//        return a
    }
    
    mutating func choose(n: Int) -> [Element] {
        
        var elements = [Element]()
        for _ in 1...n {
            let i = self.chooseOne()
            elements.append(i)
            
        }
    
        return elements
    }
}