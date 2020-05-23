//
//  QuizResult.swift
//  Сats
//
//  Created by Головаш Анастасия on 23.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

struct QuizResult: Codable {
    let numberOfQuestions: Int
    let numberRightAnswers: Int
    let executionTime: Int
}


