//
//  GameViewController.swift
//  Unomoji
//
//  Created by Dianne Katrina Bronola on 5/23/16.
//  Copyright © 2016 Dianne Bronola. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, CardMovedDelegateProtocol {
    
    //Views
    var gameView: UIView?
    var targetCardView: UIView?
    var initialX: CGFloat = 0.0
    var constantX: CGFloat = 0.0
    var cardViewOnScreen = [CardView]()
    var cardtoHide: CardView?
    let ScreenWidth = UIScreen.mainScreen().bounds.size.width
    let ScreenHeight = UIScreen.mainScreen().bounds.size.height
    var monsterTextLabel: UILabel?
    
    //Game Variables
    var cardDeck: [Card] = Card.deckOfCards
    var playerUser: Player?
    var playerCPU: Player?
    var cardShowing: Card?
    var playerWonandGameOver: Bool = false
    //CPU Variables
    var userCurrentCard: [Card]?
    var cpuThrowCard: Card?
    var cpuCurrentCard: [Card]?
    var cpuPlayable: [Card]?
    
    
    //timer
    var secondsLeft = 5


    override func viewDidLoad() {
        super.viewDidLoad()
        //Views
        gameView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        gameView!.backgroundColor = UIColor(red:0.38, green:0.42, blue:0.68, alpha:1.0)
        self.view.addSubview(gameView!)
        
        let xtarget: CGFloat = ScreenWidth/2 - 100/2
        let ytarget: CGFloat = ScreenHeight * 0.10
        targetCardView = UIView(frame: CGRectMake(xtarget, ytarget, 100.0, 130.0))
        gameView!.addSubview(targetCardView!)
        
        //monster to defeat
        let monsterView = UIView(frame: CGRectMake(xtarget + 200, ytarget-25, 100, 130))
        let monsterLabel = UILabel(frame: monsterView.bounds)
        monsterLabel.textAlignment = NSTextAlignment.Center
        monsterLabel.text = "👽"
        monsterLabel.font = monsterLabel.font.fontWithSize(100)
        monsterView.addSubview(monsterLabel)
        gameView!.addSubview(monsterView)
        
        //monster text label
        monsterTextLabel = UILabel(frame: CGRectMake(xtarget+150, ytarget+70, 250, 100))
        monsterTextLabel!.text = "Me hungry!"
        monsterTextLabel!.adjustsFontSizeToFitWidth = true
        gameView!.addSubview(monsterTextLabel!)
        
        //draw button view
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(xtarget-200, ytarget, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Draw", forState:  UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        gameView!.addSubview(button)
        
        // uno
        let unoButton = UIButton(type: UIButtonType.System) as UIButton
        unoButton.frame = CGRectMake(xtarget-200, ytarget+70, 100, 50)
        unoButton.backgroundColor = UIColor.orangeColor()
        unoButton.setTitle("UNOMOJI!", forState: UIControlState.Normal)
        //add target later
        unoButton.addTarget(self, action: "unoButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        gameView!.addSubview(unoButton)
        
        
        //for first cards dealt
        //first cards dealt
        initialX = ScreenWidth * 0.10
        constantX = (ScreenWidth * 0.70) / 5
        
        dealFirstCards()
        
    }
    
    //GAME METHODS
        //new game
    
    func dealFirstCards () {
        
        cardShowing = cardDeck.chooseOne()
        
        //choose cards for playeruser
        let firstCards: [Card] = cardDeck.choose(5)
       
        //using xtarget here as xoffset, show cardshowing on the target spot
        cardtoHide = makeCard(ScreenWidth/2 - 100/2, card: cardShowing!, isShowing: true)
        cardtoHide!.userInteractionEnabled = false
        let cShowingIndex = cardViewOnScreen.indexOf(cardtoHide!)
        cardViewOnScreen.removeAtIndex(cShowingIndex!)
    
   
        for i in firstCards {
            makeCard(initialX, card: i, isShowing: false)
            initialX += constantX
        }
        
        userCurrentCard = firstCards
        cpuCurrentCard = cardDeck.choose(5)
        playerUser = Player(name: "Ash", cardsOnHand: userCurrentCard!)
        playerCPU = Player(name: "CPU", cardsOnHand: cpuCurrentCard!)
    }
    
    
    func cpuPlays(card: CardView) {
        
        cpuPlayable = playerCPU!.playableCards(cardShowing!)
        if playerCPU!.count() == 1 || cardViewOnScreen.count == 1 {
            gameOver()
        }
        
        if cpuPlayable!.count > 0 {
            cpuThrowCard = playerCPU!.throwCard(cpuPlayable![0])
            cardShowing = cpuThrowCard
            cardtoHide = self.makeCard(0, card: self.cpuThrowCard!, isShowing: true)
            let cShowingIndex = cardViewOnScreen.indexOf(cardtoHide!)
            cardViewOnScreen.removeAtIndex(cShowingIndex!)
            card.hidden = true
            cpuCurrentCard = playerCPU!.cardsOnHand
            monsterTextLabel!.text = "MWAHAHAH I only have \(cpuCurrentCard!.count) cards left!"
        } else {
            if cardDeck.count == 0 {
                gameOver()
            } else {
                let pickThisCard = cardDeck.choose(1)[0]
                playerCPU!.pickCard(pickThisCard)
                cpuCurrentCard = playerCPU!.cardsOnHand
                monsterTextLabel!.text = "Oh no! I've got \(cpuCurrentCard!.count) now! grrr"
            }
            
        }
    }
    
    func gameOver() {
        //count each players cards left, who ever has less won the game
        //present view controller for the winner, ask to restart the game
        if playerCPU!.count() < cardViewOnScreen.count {
            monsterTextLabel!.text = "YES I WON"
        }
        else {
            monsterTextLabel!.text = "OH NO!!!!!!"
        }
    }
    
    
    
    // CARDVIEW DELEGATE, what will happen when card is tapped?
    func cardView(cardView: CardView, didMoveToPoint point: CGPoint) {
        if cardViewOnScreen.count == 1 {
            setTimer()
        }
        //check if playable
        if playerUser!.isPlayable(cardView, cardShowing: cardShowing!) == true {
            let cvIndex = cardViewOnScreen.indexOf(cardView)
            cardViewOnScreen.removeAtIndex(cvIndex!)
            //update cardShowing
            cardShowing = cardView.card
            UIView.animateWithDuration(0.35, delay: 0.05, options:UIViewAnimationOptions.CurveEaseIn, animations: {
                cardView.center = point
                if let cardtoHide = self.cardtoHide {
                    cardtoHide.hidden = true
                }
                }, completion: {
                    (value:Bool) in self.cardtoHide = cardView
                    cardView.userInteractionEnabled = false
                    UIView.animateWithDuration(3.0, animations: {
                        self.cpuPlays(self.cardtoHide!)
                        })
            
                })
        
        }
    }
    
    
    //TIMER
    
    func setTimer() {
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "tick:", userInfo: nil, repeats: true)
        timer.fire()
        
    }
    func tick(timer: NSTimer) {
        if secondsLeft == 0 && playerWonandGameOver == false {
            timer.invalidate()
            let controller = storyboard!.instantiateViewControllerWithIdentifier("show")
            presentViewController(controller, animated: true, completion: nil)
        }
        secondsLeft-=1
    }


    
    func unoButtonAction() {
        //player won
        playerWonandGameOver = true
        gameOver()
    }
    
    //METHODS FOR MAKING CARDVIEWS
    func makeCard(xOffset: CGFloat, card: Card, isShowing: Bool) -> CardView{
        let showingCenter = targetCardView!.center
        let card = CardView(xOffset: xOffset, toCenter: showingCenter, card: card, isShowing: isShowing)
        card.movedDelegate = self
        gameView!.addSubview(card)
        cardViewOnScreen.append(card)
        return card
    }
    
    
    
    
    //UPDATING VIEW
    func buttonAction(sender:UIButton!){
        //Todo: check first if there is a card to pick, otherwise gameover
        if cardDeck.count == 0 {
            gameOver()
        } else {
            //showingcard should not move
            let showingCenter = targetCardView!.center
            let newCard = CardView(xOffset: initialX, toCenter: showingCenter, card: cardDeck.chooseOne(), isShowing: false)
            newCard.movedDelegate = self
            cardViewOnScreen.append(newCard)
            self.gameView!.addSubview(newCard)
            UIView.animateWithDuration(0.5, animations: { self.updateViewCards()})
            self.cpuPlays(self.cardtoHide!)
        }
    }
    
    func getXNewconstant() -> CGFloat {
        let xConstant: CGFloat = ceil((ScreenWidth * 0.70) / CGFloat(cardViewOnScreen.count))
        return xConstant
        
    }
    
    func updateViewCards(){
        var initialx = ScreenWidth * 0.10
        let constantx = getXNewconstant()
        
        for i in cardViewOnScreen{
            i.center.x = initialx
            initialx += constantx
        }
        
    }
    
    

   


}

