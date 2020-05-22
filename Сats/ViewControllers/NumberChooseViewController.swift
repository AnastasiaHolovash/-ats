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
        
        allResults = BreadsManager.shared.quizResult
        tableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        allResults = BreadsManager.shared.quizResult
        tableView.reloadData()
    }
    
    @IBAction func didPressNumberButton(_ sender: UIButton) {

        guard let quizVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
        quizVC.numberOfQuestions = Int(sender.tag)
        self.navigationController?.pushViewController(quizVC, animated: true)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as! BreedTableViewCell
        // Gets one result by index
        let oneResult = allResults[indexPath.row]
        cell.nameLabel.text = "\(oneResult.numberRightAnswers) / \(oneResult.numberOfQuestions)"
        cell.detailLabel.text = "time"
        cell.arrowView.isHidden = true
        cell.roundImageView.isHidden = true
        cell.roundColorLabel.isHidden = false
        cell.roundColorLabel.backgroundColor = chooseColor(numberOfQuestions: oneResult.numberOfQuestions)
        cell.roundColorLabel.text = "\(calculatesPercentage(numberOfQuestions: oneResult.numberOfQuestions, numberRightAnswers: oneResult.numberRightAnswers))%"
        cell.roundColorLabel.layer.cornerRadius = CGFloat(Double(cell.roundColorLabel.frame.height) / 2)
        cell.isUserInteractionEnabled = false
        cell.layer.masksToBounds = true
        return cell
    }
    
    
    func intTimeToString(_ intTime: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(intTime))
        return formatter.string(from: date)
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
