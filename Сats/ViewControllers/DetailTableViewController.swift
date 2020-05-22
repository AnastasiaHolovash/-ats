//
//  DetailTableViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 13.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, DetailTableViewDelegate {
    
//    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var updateImageButton: UIButton!
    
    // Variables
    
    /// Breed which is shown
    public var breed: CatBreed?
    /// Array with breed information with String type
    private var breedArray: [[String]] = [[], []]
    /// Array with URLs with sites with information about breed
    private var urls: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DetailTableViewDelegate
        guard let customTV = self.tableView as? DetailTableView else { return }
        customTV.detailTableViewDelegate = self

        nameLabel.text = breed?.name
        createBreedArray()
        setImage()
    }
    
    // DetailTableViewDelegate
    func setTitle(_ needSetTitle: Bool) {
        if needSetTitle {
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
            catImageView.loadImage(withUrl: "https://api.thecatapi.com/v1/images/search?breed_id=\(breed.id)", addImageToCache: true)
        }
    }
    
    func createBreedArray() {
        if let breed = breed {
            breedArray[0].append("Id: \(breed.id)")
            breedArray[0].append("Name: \(breed.name)")
            breedArray[0].append("Temperament: \(breed.temperament)")
            breedArray[0].append("Origin: \(breed.origin)")
            breedArray[0].append("CountryCodes: \(breed.countryCodes)")
            breedArray[0].append("Purple Description: \(breed.purpleDescription)")
            breedArray[0].append("Life Span: \(breed.lifeSpan)")
            breedArray[0].append("Indoor: \(breed.indoor)")
            breedArray[0].append("Lap: \(nilCheck(breed.lap))")
            breedArray[0].append("AltNames: \(String(describing: breed.altNames ?? "-"))")
            breedArray[0].append("Adaptability: \(breed.adaptability)")
            breedArray[0].append("Weight: \(breed.weight.metric)")
            breedArray[0].append("Adaptability: \(breed.adaptability)")
            breedArray[0].append("Affection Level: \(breed.affectionLevel)")
            breedArray[0].append("Child Friendly: \(breed.childFriendly)")
            breedArray[0].append("Dog Friendly: \(breed.dogFriendly)")
            breedArray[0].append("Energy Level: \(breed.energyLevel)")
            breedArray[0].append("Grooming: \(breed.grooming)")
            breedArray[0].append("Health Issues: \(breed.healthIssues)")
            breedArray[0].append("Intelligence: \(breed.intelligence)")
            breedArray[0].append("Shedding Level: \(breed.sheddingLevel)")
            breedArray[0].append("Social Needs: \(breed.socialNeeds)")
            breedArray[0].append("Stranger Friendly: \(breed.strangerFriendly)")
            breedArray[0].append("Vocalisation: \(breed.vocalisation)")
            breedArray[0].append("Experimental: \(breed.experimental)")
            breedArray[0].append("Hairless: \(breed.hairless)")
            breedArray[0].append("Natural: \(breed.natural)")
            breedArray[0].append("Rare: \(breed.rare)")
            breedArray[0].append("Rex: \(breed.rex)")
            breedArray[0].append("Suppressed Tail: \(breed.suppressedTail)")
            breedArray[0].append("Short Legs: \(breed.shortLegs)")
            breedArray[0].append("Hypoallergenic: \(breed.hypoallergenic)")
            breedArray[0].append("Cat Friendly: \(nilCheck(breed.catFriendly))")
            breedArray[0].append("Bidability: \(nilCheck(breed.bidability))")
            
            emptyURLsCheck(breed.cfaURL, urlName: "Cfa")
            emptyURLsCheck(breed.vetstreetURL, urlName: "Vetstreet")
            emptyURLsCheck(breed.vcahospitalsURL, urlName: "Vcahospitals")
            emptyURLsCheck(breed.wikipediaURL, urlName: "Wikipedia")
        }
        
    }
    
    func nilCheck(_ intData: Int?) -> String {
        if let intData = intData {
            return String(intData)
        } else {
            return "There is no such information."
        }
    }
    func emptyURLsCheck(_ urlData: String?, urlName: String) {
        if let urlData = urlData {
            breedArray[1].append("\(urlName)")
            urls.append(urlData)
        }
    }
    
    
    @IBAction func didPressUpdateImageButton(_ sender: UIButton) {
        if let breed = breed {
            catImageView.loadImage(withUrl: "https://api.thecatapi.com/v1/images/search?breed_id=\(breed.id)", addImageToCache: true)
        }
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Information"
        case 1:
            return "More info:"
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
        if indexPath.section == 1 {
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.textAlignment = .center
        }
        cell.textLabel?.text = breedArray[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let webVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
            
            webVC.urlString = urls[indexPath.row]
            
            let navigationC = UINavigationController()
            navigationC.viewControllers = [webVC]
            
            present(navigationC, animated: true, completion: nil)
        }
    }

    
}
