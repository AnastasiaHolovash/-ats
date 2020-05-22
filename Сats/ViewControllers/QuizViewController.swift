//
//  QuizViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 21.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var curentNumberLabel: UILabel!
    
    //Variables
    var numberOfQuestions: Int = 0
    var questionCurentNumber: Int = 1
    var rightAnswerPlacement: Int = 0
    var numberOfRightAnsvers: Int = 0
    var selectedAnswerButton: Int = 0
    
    var answerButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var answerButton = UIButton()
        for i in 1...4 {
            answerButton = view.viewWithTag(i) as! UIButton
            answerButton.layer.cornerRadius = CGFloat(Double(answerButton.frame.height) / 3.5)
            answerButtons.append(answerButton)
        }
        nextButton.setTitle("Ansver", for: .normal)
        nextButton.layer.cornerRadius = CGFloat(Double(nextButton.frame.height) / 3.5)
        
        rabdomPicture()
    }
        
    
    @IBAction func didPressAnswerButton(_ sender: UIButton) {
        clearAnswerButtonsColor()
        answerButtons[sender.tag - 1].backgroundColor = .systemOrange
        selectedAnswerButton = sender.tag
        nextButton.backgroundColor = .systemIndigo
        nextButton.isEnabled = true
    }
    
    /**
    Checks whether the answer is correct.
    
    If correct sets taped button background Color green.
    If wrong sets red  and show correct answer highlighting it in green.
    */
    func showTheCorrectAnswer(tag: Int) {
//        var answerButton = UIButton()
        var answerButton = answerButtons[tag - 1]
        
        if tag == rightAnswerPlacement {
            numberOfRightAnsvers += 1
            answerButton.backgroundColor = .systemGreen
        } else {
            answerButton.backgroundColor = .systemRed
            answerButton = answerButtons[rightAnswerPlacement - 1]
            answerButton.backgroundColor = .systemGreen
        }
        isEnabledAnswerButtons(false)
    }
    
    /**
     Controls number of questions.
     
     Shows alert with results and pop ViewController when all questions was shown.
     */
    @IBAction func didPressNextButton(_ sender: UIButton) {
        if nextButton.titleLabel?.text == "Ansver" {
            showTheCorrectAnswer(tag: selectedAnswerButton)
            nextButton.setTitle("Next", for: .normal)
            return
        }
        if questionCurentNumber <= numberOfQuestions {
            if questionCurentNumber == numberOfQuestions {
                nextButton.setTitle("View results", for: .normal)
            }
            nextButton.isEnabled = false
            nextButton.backgroundColor = .lightGray
            nextButton.setTitle("Ansver", for: .normal)
            isEnabledAnswerButtons(true)
            rabdomPicture()
            clearAnswerButtonsColor()
        } else {
            let alert = UIAlertController(title: "Congratulations!", message: "You gave \(numberOfRightAnsvers)/\(numberOfQuestions) correct answers", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { (handler) in
                DispatchQueue.main.async {
                    self.apdateResults()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func apdateResults() {
        let result = QuizResult(numberOfQuestions: numberOfQuestions, numberRightAnswers: numberOfRightAnsvers, executionTime: 0)
        var allResults = BreadsManager.shared.quizResult
        allResults.append(result)
        BreadsManager.shared.quizResult = allResults
    }
    
    /**
     Func that randomly selects a picture and wrong answers.
     
     Also controls label which shows how many answers have already been given.
     */
    func rabdomPicture() {
        
        curentNumberLabel.text = "\(questionCurentNumber)/\(numberOfQuestions)"
        var otherCatsNames: [String] = []
        // right Cat choosing
        guard let rightCat = BreadsManager.shared.breedsArray.randomElement() else { return }
        // sets image of right Cat
        imageView.loadImage(withUrl: "https://api.thecatapi.com/v1/images/search?breed_id=\(rightCat.id)", addImageToCache: false)
        // other 3 Cats choosing
        for _ in 0..<3 {
            guard let otherCat = BreadsManager.shared.breedsArray.randomElement() else { return }
            otherCatsNames.append(otherCat.name)
        }
        // place for right answer choosing
        rightAnswerPlacement = Int.random(in: 1 ... 4)
        
        // sets titles for buttons
        var x = 0
        for i in 1...answerButtons.count {
            if i == rightAnswerPlacement {
                answerButtons[i - 1].setTitle(rightCat.name, for: .normal)
            } else {
                answerButtons[i - 1].setTitle(otherCatsNames[x], for: .normal)
                x += 1
            }
        }
        questionCurentNumber += 1
    }
    
    /// Sets Answer Buttons Color in the initial
    func clearAnswerButtonsColor() {
        for button in answerButtons {
            button.backgroundColor = .white
        }
    }
    /// Sets Answer Buttons disable
    func isEnabledAnswerButtons(_ isEnabled: Bool) {
        for button in answerButtons {
            button.isEnabled = isEnabled
        }
    }
    
    

}
