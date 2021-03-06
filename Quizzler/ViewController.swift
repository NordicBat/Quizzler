//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }

// check wich button was clicked
    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber += 1
        nextQuestion()
    }
    
//    update the labels and the progressbar in the main screen
    func updateUI() {
      
        scoreLabel.text = "SCORE : \(score)"
        
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    
// calls the next question from the list
    func nextQuestion() {
        
        if questionNumber <= (allQuestions.list.count - 1)  {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            let alert = UIAlertController(title: "Noice", message: "all questions answered, continue?", preferredStyle: .alert)
            updateUI()
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()})
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
//    check if the answer is correct, and usses the ProgressHUD lib to pop up feedback
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            score += 10
            ProgressHUD.showSuccess("Correct")
        } else {
            score -= 10
            ProgressHUD.showError("Wrong")
        }
        
    }
    
//  restart the game
    func startOver() {
       
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
