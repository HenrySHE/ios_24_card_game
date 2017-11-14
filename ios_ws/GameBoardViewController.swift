//
//  GameBoardViewController.swift
//  ios_ws
//
//  Created by Hao Yu She on 2017/11/6.
//  Copyright © 2017年 Hao Yu She. All rights reserved.
//

import UIKit

class GameBoardController: UIViewController {
    
    @IBOutlet var cardButtons: Array<UIButton>!
    @IBOutlet var operButtons: Array<UIButton>!
    
    @IBOutlet var enterBtn: UIButton!
    
    @IBOutlet weak var calculation: UILabel!
    @IBOutlet weak var calResult: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var deck: Deck! //can hold different value, incase it is not successful
    var game: Game!
    
    var cardSelected: Int = 0
    var result: Int = 0
    var score: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        game = Game()
        deck = Deck()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain,
                                                                target: self,
                                                                action: #selector(GameBoardController.backButtonItemToDismissModal))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNavTitle(newUserName: String){
        self.navigationItem.title = newUserName + "'s Card 24 Game"
    }
    
    
    
    @objc func backButtonItemToDismissModal(){
        self.dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardSelected = 0
        result = 0
        score = 0
        self.resetUI()
        self.randomCards()
        self.scoreLabel.text = "0"
    }
    
    @IBAction func clearInput(sender: UIButton) {
        
        cardSelected = 0
        result = 0
        self.resetUI()
        self.game.clearPreString()
    }
    
    @IBAction func nextCards(sender: UIButton) {
        
        cardSelected = 0
        result = 0
        self.randomCards()
        self.resetUI()
        self.game.clearPreString()
    }
    
    @IBAction func enterResult(sender: UIButton) {
        
        enterBtn.isEnabled = false
        enterBtn.alpha = 0.3
        cardSelected = 0
        
        let equation = self.game.getEquation() as String
        result = self.game.calculator(equation:equation)
        let resultStr = String(result)
        
        if resultStr != "-99999" {
            calResult.text = resultStr
        } else {
            calResult.text = "Invalid Equation"
        }
        
        if result == 24 {
            score += 2
        } else {
            score -= 1
        }
        
        scoreLabel.text = String(score)
    }
    
    @IBAction func chooseCard(sender: UIButton) {
        
        cardSelected = cardSelected+1
        sender.isEnabled = false
        sender.alpha = 0.3
        
        let newStr = calculation.text! + sender.currentTitle!
        
        calculation.text = newStr
        self.game.pushCard(card:sender.currentTitle!)
        
        
    }
    
    @IBAction func operation(sender: UIButton) {
        
        if sender.isSelected {
            
            return
        }
        
        sender.isSelected = !sender.isSelected
        calculation.text = calculation.text! + sender.currentTitle!
        self.game.pushOperation(operation:sender.currentTitle!)
    }
    
    func resetUI() {
        
        enterBtn.isEnabled = true
        enterBtn.alpha = 1
        for cardButton in cardButtons {
            cardButton.isEnabled = true
            cardButton.alpha = 1
            
        }
        
        for operButton in operButtons {
            
            operButton.isSelected = false
            
        }
        
        calResult.text = ""
        calculation.text = ""
        
    }
    
    func randomCards() {
        
        for cardButton in cardButtons {
            let card = self.deck.drawRandomCard() as Card
            cardButton.setTitle(card.suit+card.rank, for: UIControlState.normal)
        }
    }
}

