//
//  ViewController.swift
//  be
//
//  Created by Nitin Singh on 24/01/20.
//  Copyright © 2020 Nitin Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue : Int = 0
    var randomNumber : Int = 0
    var score = 0
    var round = 1
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        currentValue = Int(slider.value.rounded())
        
        valueShownonRound()
        valueShowonScore()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for:.normal)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SmallButton")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
     }
    
    @IBAction func showword() {
        var difference: Int
        difference = abs(currentValue - randomNumber)
        let points = 100 - difference
        score += points
        
        var title: String
        if difference > 15 {
            title = "NOT EVEN CLOSE 😫"
            score -= 10
        } else if difference > 10 {
            title = "KEEP TRYING 🙂"
            score += 5
        } else {
            title = "🤩"
            score += 20
        }
        
        var k: String
        if difference == 0 {
            k = "👍🏻 CONGRATULATIONS 🏆 !"
        } else {
            k =  "Here is the difference :\(difference)"
        }
        
        let message = ("\n \(k) \n YOUR SCORE IS :\(points)")
        
        let alert = UIAlertController(title:title, message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "TAP", style:.default, handler:{
            action in
            self.startNewRound()
            self.valueShowonScore()
        })
        alert.addAction(action)
    
        
        // height constraint
        let constraintHeight = NSLayoutConstraint(
           item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
           NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        alert.view.addConstraint(constraintHeight)

        // width constraint
        let constraintWidth = NSLayoutConstraint(
           item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
           NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
        alert.view.addConstraint(constraintWidth)
        
        present(alert, animated: true, completion: nil)
      
        }
    
    @IBAction func sliderValue(_ slider:UISlider) {
        currentValue = Int(slider.value.rounded())
    }
     
    func startNewRound() {
        round += 1
        currentValue = 50
        randomNumber = Int.random(in: 1...100)
        slider.value = Float(currentValue)
        valueShowonTop()
        valueShownonRound()
        }
    func valueShowonTop() {
        
        targetLabel.text = String(randomNumber)
    }
    
    func valueShowonScore() {
        scoreLabel.text = String(score)
    }
    func valueShownonRound() {
        roundLabel.text = String(round)
    }
    @IBAction func startRound() {
        round = 1
        score = 0
        valueShowonScore()
        valueShownonRound()
    }
}
