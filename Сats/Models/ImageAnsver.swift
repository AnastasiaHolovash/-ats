//
//  ImageAnsver.swift
//  Сats
//
//  Created by Головаш Анастасия on 23.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

struct ImageAnsver: Codable {
    let breeds: [CatBreed]
    let height: Int
    let id: String
    let url: String
    let width: Int
}
