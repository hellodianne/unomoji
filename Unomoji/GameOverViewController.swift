//
//  GameOverViewController.swift
//  Unomoji
//
//  Created by Dianne Katrina Bronola on 5/27/16.
//  Copyright © 2016 Dianne Bronola. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    
    @IBOutlet weak var whoWon: UILabel!
    var whoWonText: String! = "Congratulations You Won!"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whoWon.text = whoWonText
    }
}
