//
//  ViewController.swift
//  jogodavelha
//
//  Created by Arilson Carmo on 12/27/15.
//  Copyright © 2015 Arilson Carmo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var activePlayer = 1;
    var gameState: [Int] = [0,0,0,0,0,0,0,0,0];
    let winningCombinations = [[0,1,2], [3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8], [2,4,6]]
    var gameActive = true;
    var gameTurns = 0;
    
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var playAgain: UIButton!
    
    @IBAction func actionButton(sender: AnyObject) {
        //jogo da velha events
        let contentImage : UIImage? = UIImage(CIImage: sender.image())
        var gameImage = UIImage()
        
        //verify if this tag has been used
        if(gameState[sender.tag] == 0 && gameActive == true){
            gameTurns++
            gameState[sender.tag] = activePlayer
            
            if(contentImage == nil){
                if(activePlayer == 1){
                    gameImage = UIImage(named: "circle.png")!
                    activePlayer = 2;
                }else{
                    gameImage = UIImage(named: "cross.png")!
                    activePlayer = 1;
                }
            }
            
            sender.setImage(gameImage, forState: .Normal)
            
            for combination in winningCombinations {
                
                print("combination",combination)
                print("winningCombination", gameState[combination[0]])
                
                if(gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]){
                    //verify winner!
                    if(activePlayer == 1){
                        gameOverLabel.text = "X VENCEU!!!"
                        gameOverLabel.hidden = false;
                        playAgain.hidden = false;
                        gameOverLabel.backgroundColor = UIColor(red:0.18, green:0.75, blue:0.37, alpha:1)
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
                            
                            self.playAgain.center = CGPointMake(self.playAgain.center.x + 500, self.playAgain.center.y)
                        })
                    }else{
                        gameOverLabel.text = "BOLINHA VENCEU!!!"
                        gameOverLabel.hidden = false;
                        gameOverLabel.backgroundColor = UIColor(red:0.18, green:0.75, blue:0.37, alpha:1)
                        playAgain.hidden = false;
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
                            
                            self.playAgain.center = CGPointMake(self.playAgain.center.x + 500, self.playAgain.center.y)
                        })
                    }
                    gameActive = false;
                }
            }
            //IN TIE CASE CALL TIE MODAL.
            if(gameTurns >= 9 && gameOverLabel.hidden){
                gameActive = false
                gameOverLabel.text = "EMPATE!!!"
                gameOverLabel.backgroundColor = UIColor(red:0.91, green:0.29, blue:0.25, alpha:1)
                gameOverLabel.hidden = false;
                playAgain.hidden = false;
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
                })
            }
            
        }
        
    }
    
    @IBAction func playAgainAction(sender: AnyObject) {
        initialization();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    //Reset All states of the game.
    func initialization(){
        gameTurns = 0
        gameState = [0,0,0,0,0,0,0,0,0]
        activePlayer = 1
        gameActive = true
        playAgain.hidden = true
        gameOverLabel.hidden = true
        
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
        
        for(var i = 0; i < 9; i++){
            button = view.viewWithTag(i) as! UIButton;
            
            button.setImage(nil, forState: .Normal)
        }
    }
    
    func showWinner(winner: String){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

