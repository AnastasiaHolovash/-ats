//
//  BreadsManager.swift
//  Сats
//
//  Created by Головаш Анастасия on 21.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class BreadsManager {
    
    static let shared = BreadsManager()
    /// Array of all breeds geting from server
    var breedsArray: [CatBreed] = []
    /// Array of all quizzes results
    var quizResult: [QuizResult] {
        get {
            if let data = UserDefaults.standard.data(forKey: "QuizResult") {
                let decoder = JSONDecoder()
                return (try? decoder.decode([QuizResult].self, from: data)) ?? []
            } else {
                return []
            }
        }
        set {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: "QuizResult")
        }
    }
}
