//
//  CardView.swift
//  Unomoji
//
//  Created by Dianne Katrina Bronola on 5/23/16.
//  Copyright © 2016 Dianne Bronola. All rights reserved.
//

import UIKit

protocol CardMovedDelegateProtocol {
    
    func cardView(cardView: CardView, didMoveToPoint: CGPoint)
    
}

class CardView: UIView {

    let card: Card
    
    let width: CGFloat = 85.0
    let height: CGFloat = 120.0
    var toCenter: CGPoint
    
    let ScreenHeight = UIScreen.mainScreen().bounds.size.height
    let ScreenWidth = UIScreen.mainScreen().bounds.size.width
    
    
    var movedDelegate: CardMovedDelegateProtocol?
    
    required init(coder aDecoder: NSCoder){
        fatalError("use init(number: xOffset:")
    }
    
    init(xOffset: CGFloat, toCenter: CGPoint, card: Card, isShowing: Bool){
        self.card = card
        self.toCenter = toCenter
     
        
        
        let xtarget: CGFloat = ScreenWidth/2 - 100/2
        let ytarget: CGFloat = ScreenHeight * 0.10
        
        let showingFrame = CGRect(x: xtarget, y: ytarget, width: width, height: height)
        let frame = CGRect(x: xOffset, y: ScreenHeight * 0.70, width: width, height: height)
        if isShowing == true {
            super.init(frame: showingFrame)
        } else {
            super.init(frame: frame)
        }
        let emLabel = UILabel(frame: self.bounds)
        emLabel.textAlignment = NSTextAlignment.Center
        //emLabel.textColor = UIColor.whiteColor()
        emLabel.text = card.emoji
        emLabel.font = emLabel.font.fontWithSize(78)
        self.addSubview(emLabel)
        
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 2.0
        self.backgroundColor = card.color
        self.userInteractionEnabled = true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            movedDelegate?.cardView(self, didMoveToPoint: self.toCenter)
            
        }
    }
    
    
}
