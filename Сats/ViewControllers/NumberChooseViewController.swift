//
//  NumberChooseViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 21.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class NumberChooseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressNumberButton(_ sender: UIButton) {

        guard let quizVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
        quizVC.numberOfQuestions = Int(sender.tag)
        self.navigationController?.pushViewController(quizVC, animated: true)
    
    }
    
   

}
