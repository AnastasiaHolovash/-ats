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
    var numberOfRightAnswers: Int = 0
    var selectedAnswerButton: Int = 0
    var quizTime: TimeInterval = TimeInterval()
    
    /// Buttons that the user presses to give an answer
    var answerButtons: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating Answer Buttons using tags
        var answerButton = UIButton()
        for i in 1...4 {
            answerButton = view.viewWithTag(i) as! UIButton
            answerButton.layer.cornerRadius = CGFloat(Double(answerButton.frame.height) / 3.5)
            answerButtons.append(answerButton)
        }
        // Setup Next Button
        nextButton.setTitle("Answer", for: .normal)
        nextButton.isEnabled = false
        nextButton.backgroundColor = .lightGray
        nextButton.layer.cornerRadius = CGFloat(Double(nextButton.frame.height) / 3.5)
        
        randomPicture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Quiz start time
        quizTime = Date().timeIntervalSince1970
    }
    
    @IBAction func didPressAnswerButton(_ sender: UIButton) {
        clearAnswerButtonsColor()
        // Mark the selected button with orage color
        answerButtons[sender.tag - 1].backgroundColor = .systemOrange
        answerButtons[sender.tag - 1].setTitleColor(.white, for: .normal)
        // Enable Next Button after User selected the answer
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
        
        var answerButton = answerButtons[tag - 1]
        
        if tag == rightAnswerPlacement {
            numberOfRightAnswers += 1
            answerButton.backgroundColor = .systemGreen
            answerButton.setTitleColor(.white, for: .normal)
        } else {
            answerButton.backgroundColor = .systemRed
            answerButton.setTitleColor(.white, for: .normal)
            answerButton = answerButtons[rightAnswerPlacement - 1]
            answerButton.backgroundColor = .systemGreen
            answerButton.setTitleColor(.white, for: .normal)
        }
        isEnabledAnswerButtons(false)
    }
    
    /**
     Controls number of questions.
     
     Shows alert with results and pop ViewController when all questions was shown.
     */
    @IBAction func didPressNextButton(_ sender: UIButton) {
        // If title is "Answer" changes it to "Next" or "View results"
        if nextButton.titleLabel?.text == "Answer" {
            showTheCorrectAnswer(tag: selectedAnswerButton)
            if (questionCurentNumber - 1) == numberOfQuestions {
                nextButton.setTitle("View results", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
            return
        }
        // If title is not "Answer" and it was not the last question
        if questionCurentNumber <= numberOfQuestions {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .lightGray
            nextButton.setTitle("Answer", for: .normal)
            isEnabledAnswerButtons(true)
            randomPicture()
            clearAnswerButtonsColor()
        } else {
            // If title is not "Answer" and it was the last question
            // Shows alert with results
            let alert = UIAlertController(title: "Congratulations!", message: "You gave \(numberOfRightAnswers)/\(numberOfQuestions) correct answers", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { (handler) in
                DispatchQueue.main.async {
                    // Calculates quiz execution time
                    self.quizTime = Date().timeIntervalSince1970 - self.quizTime
                    self.updateResults()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    /// Update data in User defaults by using singleton BreadsManager.
    func updateResults() {
        let result = QuizResult(numberOfQuestions: numberOfQuestions, numberRightAnswers: numberOfRightAnswers, executionTime: Int(quizTime))
        var allResults = BreadsManager.shared.quizResult
        allResults.insert(result, at: 0)
        BreadsManager.shared.quizResult = allResults
    }
    
    /**
     Func that randomly selects a picture and wrong answers.
     
     Also controls label which shows how many answers have already been given.
     */
    func randomPicture() {
        
        curentNumberLabel.text = "\(questionCurentNumber)/\(numberOfQuestions)"
        var otherCatsNames: [String] = []
        //  right Cat choosing
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
            button.setTitleColor(.black, for: .normal)
        }
    }
    /// Sets Answer Buttons disable
    func isEnabledAnswerButtons(_ isEnabled: Bool) {
        for button in answerButtons {
            button.isUserInteractionEnabled = isEnabled
        }
    }

}
