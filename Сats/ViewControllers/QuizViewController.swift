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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rabdomPicture()
    }
        
    /**
     Checks whether the answer is correct.
     
     If correct sets taped button background Color green.
     If wrong sets red  and show correct answer highlighting it in green.
     
     Also hiddes nextButton.
     */
    @IBAction func didPressAnswerButton(_ sender: UIButton) {
        var answerButton = UIButton()
        answerButton = view.viewWithTag(sender.tag) as! UIButton
        
        if sender.tag == rightAnswerPlacement {
            numberOfRightAnsvers += 1
            answerButton.backgroundColor = .systemGreen
        } else {
            answerButton.backgroundColor = .systemRed
            answerButton = view.viewWithTag(rightAnswerPlacement) as! UIButton
            answerButton.backgroundColor = .systemGreen
        }
        nextButton.isHidden = false
    }
    
    /**
     Controls number of questions.
     
     Shows alert with results and pop ViewController when all questions was shown.
     */
    @IBAction func didPressNextButton(_ sender: UIButton) {
        if questionCurentNumber <= numberOfQuestions {
            if questionCurentNumber == numberOfQuestions {
                nextButton.setTitle("View results", for: .normal)
            }
            rabdomPicture()
            clearAnswerButtonsColor()
        } else {
            let alert = UIAlertController(title: "Congratulations!", message: "You gave \(numberOfRightAnsvers)/\(numberOfQuestions) correct answers", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default) { (handler) in
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    /**
     Func that randomly selects a picture and wrong answers.
     
     Also controls label which shows how many answers have already been given.
     */
    func rabdomPicture() {
        nextButton.isHidden = true
        curentNumberLabel.text = "\(questionCurentNumber)/\(numberOfQuestions)"
        var otherCatsNames: [String] = []
        // right Cat choosing
        guard let rightCat = BreadsManager.shared.breedsArray.randomElement() else { return }
        // sets image of right Cat
        imageView.loadImageUsingCache(withUrl: "https://api.thecatapi.com/v1/images/search?breed_id=\(rightCat.id)")
        // other 3 Cats choosing
        for _ in 0..<3 {
            guard let otherCat = BreadsManager.shared.breedsArray.randomElement() else { return }
            otherCatsNames.append(otherCat.name)
        }
        // place for right answer choosing
        rightAnswerPlacement = Int.random(in: 1 ... 4)
        // sets titles for buttons
        var answerButton = UIButton()
        var x = 0
        for i in 1...4 {
            answerButton = view.viewWithTag(i) as! UIButton
            if i == rightAnswerPlacement {
                answerButton.setTitle(rightCat.name, for: .normal)
            } else {
                answerButton.setTitle(otherCatsNames[x], for: .normal)
                x += 1
            }
        }
        questionCurentNumber += 1
    }
    
    /// Sets Answer Buttons Color in the initial
    func clearAnswerButtonsColor() {
        var answerButton = UIButton()
        for i in 1...4 {
            answerButton = view.viewWithTag(i) as! UIButton
            answerButton.backgroundColor = .clear
        }
    }
    

}
