//
//  ViewController.swift
//  CatchTheGary
//
//  Created by Zehra Nur Açık on 5.08.2024.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var counter = 0
    var highscore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var garyArray = [UIImageView]()
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var gary2: UIImageView!
    @IBOutlet weak var gary1: UIImageView!
    @IBOutlet weak var gary3: UIImageView!
    @IBOutlet weak var gary4: UIImageView!
    @IBOutlet weak var gary5: UIImageView!
    @IBOutlet weak var gary6: UIImageView!
    @IBOutlet weak var gary7: UIImageView!
    @IBOutlet weak var gary8: UIImageView!
    @IBOutlet weak var gary9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighscore == nil {
            highscore = 0
            highScoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = storedHighscore as? Int{
            highscore = newScore
            highScoreLabel.text = "Highscore: \(highscore)"
        }
        
        gary1.isUserInteractionEnabled = true
        gary2.isUserInteractionEnabled = true
        gary3.isUserInteractionEnabled = true
        gary4.isUserInteractionEnabled = true
        gary5.isUserInteractionEnabled = true
        gary6.isUserInteractionEnabled = true
        gary7.isUserInteractionEnabled = true
        gary8.isUserInteractionEnabled = true
        gary9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        gary1.addGestureRecognizer(recognizer1)
        gary2.addGestureRecognizer(recognizer2)
        gary3.addGestureRecognizer(recognizer3)
        gary4.addGestureRecognizer(recognizer4)
        gary5.addGestureRecognizer(recognizer5)
        gary6.addGestureRecognizer(recognizer6)
        gary7.addGestureRecognizer(recognizer7)
        gary8.addGestureRecognizer(recognizer8)
        gary9.addGestureRecognizer(recognizer9)
        
        garyArray = [gary1,gary2,gary3,gary4,gary5,gary6,gary7,gary8,gary9]
        
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideGary), userInfo: nil, repeats: true)
        
        hideGary()
    }
    
    @objc func hideGary(){
        for gary in garyArray{
            gary.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(garyArray.count-1)))
        garyArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score+=1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > self.highscore {
                self.highscore = self.score
                self.highScoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.setValue(self.highscore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text =  "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideGary), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil )
        }
    }


}

