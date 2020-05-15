//
//  DetailTableViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 13.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, DetailTableViewDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    public var breed: CatBreed?
    private var breedArray: [[String]] = [[], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let serchVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchTableViewController").sub as? DetailTableView else { return }
//        tableView.mydelegate = self
        nameLabel.text = breed?.name
//        self.title = breed?.name
        createBreedArray()
        setImage()
    }
    
    func setTitle() {
        if self.title == "" {
            self.title = breed?.name
        } else {
            self.title = ""
        }
    }
    
    func setImage() {
        if let breed = breed {
            // check cached image
            if let cachedImage = imageCache.object(forKey: "https://api.thecatapi.com/v1/images/search?breed_id=\(breed.id)" as NSString)  {
                catImageView.image = cachedImage
                return
            }
            // if not, download image from url
            catImageView.loadImageUsingCache(withUrl: "https://api.thecatapi.com/v1/images/search?breed_id=\(breed.id)")
        }
    }
    
    func createBreedArray() {
        if let breed = breed {
            breedArray[0].append("id: \(breed.id)")
            breedArray[0].append("name: \(breed.name)")
            breedArray[1].append("cfaURL: \(breed.cfaURL ?? "")")
            breedArray[1].append("vetstreetURL: \(String(describing: breed.vetstreetURL))")
            breedArray[1].append("vcahospitalsURL: \(String(describing: breed.vcahospitalsURL))")
            breedArray[0].append("temperament: \(breed.temperament)")
            breedArray[0].append("origin: \(breed.origin)")
            breedArray[0].append("countryCodes: \(breed.countryCodes)")
            breedArray[0].append("purpleDescription: \(breed.id)")
            breedArray[0].append("id: \(breed.purpleDescription)")
            breedArray[0].append("lifeSpan: \(breed.lifeSpan)")
            breedArray[0].append("indoor: \(breed.indoor)")
            breedArray[0].append("lap: \(String(describing: breed.lap))")
            breedArray[0].append("altNames: \(String(describing: breed.altNames))")
            breedArray[0].append("adaptability: \(breed.adaptability)")
            breedArray[0].append("weight: \(breed.weight.metric)")
            breedArray[0].append("adaptability: \(breed.adaptability)")
            breedArray[0].append("affectionLevel: \(breed.affectionLevel)")
            breedArray[0].append("childFriendly: \(breed.childFriendly)")
            breedArray[0].append("dogFriendly: \(breed.dogFriendly)")
            breedArray[0].append("energyLevel: \(breed.energyLevel)")
            breedArray[0].append("grooming: \(breed.grooming)")
            breedArray[0].append("healthIssues: \(breed.healthIssues)")
            breedArray[0].append("intelligence: \(breed.intelligence)")
            breedArray[0].append("sheddingLevel: \(breed.sheddingLevel)")
            breedArray[0].append("socialNeeds: \(breed.socialNeeds)")
            breedArray[0].append("strangerFriendly: \(breed.strangerFriendly)")
            breedArray[0].append("vocalisation: \(breed.vocalisation)")
            breedArray[0].append("experimental: \(breed.experimental)")
            breedArray[0].append("hairless: \(breed.hairless)")
            breedArray[0].append("natural: \(breed.natural)")
            breedArray[0].append("rare: \(breed.rare)")
            breedArray[0].append("rex: \(breed.rex)")
            breedArray[0].append("suppressedTail: \(breed.suppressedTail)")
            breedArray[0].append("shortLegs: \(breed.shortLegs)")
            breedArray[1].append("wikipediaURL: \(String(describing: breed.wikipediaURL))")
            breedArray[0].append("hypoallergenic: \(breed.hypoallergenic)")
            breedArray[0].append("catFriendly: \(String(describing: breed.catFriendly))")
            breedArray[0].append("bidability: \(String(breed.bidability ?? 0))")
        }
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Information"
        case 1:
            return "URLs"
        default:
            return ""
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return breedArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedArray[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.text = breedArray[indexPath.section][indexPath.row]

        return cell
    }

}
