//
//  NumberChooseViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 21.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class NumberChooseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button20: UIButton!
    
    var allResults: [QuizResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Castom Cell register
        tableView.register(UINib(nibName: "BreedTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BreedTableViewCell")
        // Setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        // Rounding buttons
        button5.layer.cornerRadius = CGFloat(Double(button5.frame.height) / 2.5)
        button10.layer.cornerRadius = CGFloat(Double(button10.frame.height) / 2.5)
        button15.layer.cornerRadius = CGFloat(Double(button15.frame.height) / 2.5)
        button20.layer.cornerRadius = CGFloat(Double(button20.frame.height) / 2.5)
        
       updateQuizResults()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateQuizResults()
    }
    
    /// Getting data from User defaults by using singleton BreadsManager
    func updateQuizResults() {
        allResults = BreadsManager.shared.quizResult
        tableView.reloadData()
    }

    
    @IBAction func didPressNumberButton(_ sender: UIButton) {
        // Creates a ViewController with type QuizViewController
        guard let quizVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
        // Shares number of questions that was chosen by the user
        quizVC.numberOfQuestions = Int(sender.tag)
        // Shows QuizViewController
        self.navigationController?.pushViewController(quizVC, animated: true)
    
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as? BreedTableViewCell else { return UITableViewCell() }
        
        // Gets one result by index
        let oneResult = allResults[indexPath.row]
        // Setup table view cell
        cell.nameLabel.text = "\(oneResult.numberRightAnswers) / \(oneResult.numberOfQuestions)"
        cell.detailLabel.text = intTimeToString(oneResult.executionTime)
        cell.roundColorLabel.backgroundColor = chooseColor(numberOfQuestions: oneResult.numberOfQuestions)
        cell.roundColorLabel.text = "\(calculatesPercentage(numberOfQuestions: oneResult.numberOfQuestions, numberRightAnswers: oneResult.numberRightAnswers))%"
        cell.arrowView.isHidden = true
        cell.roundImageView.isHidden = true
        cell.roundColorLabel.isHidden = false
        cell.layer.masksToBounds = true
        cell.roundColorLabel.layer.cornerRadius = CGFloat(Double(cell.roundColorLabel.frame.height) / 2)
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    /**
     Converts time interval with Int type to String.
     - Parameters:
        - intTime: time interval with Int type.
     - Returns: time formated to String.
     */
    func intTimeToString(_ intTime: Int) -> String {
        let interval = intTime

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        
        guard let formattedString = formatter.string(from: TimeInterval(interval)) else { return "" }
        return formattedString
    }
    
    /// Calculates the percentage of correct answers.
    func calculatesPercentage(numberOfQuestions: Int, numberRightAnswers: Int) -> Int {
        return (numberRightAnswers * 100) / numberOfQuestions
    }
    
    /**
     Choose Color for table view cell for display resuls of last quizes.
     
     The color depends on number of questions.
     */
    func chooseColor(numberOfQuestions: Int) -> UIColor {
        switch numberOfQuestions {
        case 5:
            return .systemGreen
        case 10:
            return .systemIndigo
        case 15:
            return .systemOrange
        case 20:
            return .systemRed
        default:
            return .black
        }
    }
   

}
