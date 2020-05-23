//
//  DetailTableViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 13.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, DetailTableViewDelegate {
    
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
        
        // Detail table view delegate
        guard let customTV = self.tableView as? DetailTableView else { return }
        customTV.detailTableViewDelegate = self

        nameLabel.text = breed?.name
        createBreedArray()
        setImage()
    }
    
    // Detail table view delegate
    func setTitle(_ needSetTitle: Bool) {
        if needSetTitle {
            self.title = breed?.name
        } else {
            self.title = ""
        }
    }

    /// Downloads image with the breed that shown from url, if the image for this breed is not yet cached.
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
    
    /**
     Creates array with breed information with String type.
     
     Separates URL and all information on two parts of the array.
     */
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
            breedArray[0].append("AltNames: \(emptyStringCheck(string: breed.altNames))")
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
    
    /**
     Check if data with Int type is not nil.
     - Parameters:
        - intData: data with Int type.
     - Returns:
        - Data converted to String type if data is not nil.
        - "There is no such information." if data is nil.
     */
    func nilCheck(_ intData: Int?) -> String {
        if let intData = intData {
            return String(intData)
        } else {
            return "There is no such information."
        }
    }
    
    /**
    Check if URL string is not nil.
    - Parameters:
       - urlData: srting with URL.
       - urlName: information about which web page is the URL from.
    
     Add urlData to array with all URLs and urlName to array with breed information with String type.
    */
    func emptyURLsCheck(_ urlData: String?, urlName: String) {
        if let urlData = urlData {
            breedArray[1].append("\(urlName)")
            urls.append(urlData)
        }
    }
    
    /**
    Check if data with srting type is not nil.
    - Parameters:
       - string: data with srting type.
    - Returns:
       - string if data is not nil.
       - "-" if data is nil.
    */
    func emptyStringCheck(string: String?) -> String {
        if let string = string {
            return string
        } else {
            return "-"
        }
    }
    
    @IBAction func didPressUpdateImageButton(_ sender: UIButton) {
        if let breed = breed {
            // download image from url
            catImageView.loadImage(withUrl: "https://api.thecatapi.com/v1/images/search?breed_id=\(breed.id)", addImageToCache: true)
        }
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            // Displayed in the section with all information
            return "Information"
        case 1:
            // Displayed in the URLs section
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
        
        // Setup table view cell
        cell.textLabel?.numberOfLines = 10
        if indexPath.section == 1 {
            // For URLs
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.textAlignment = .center
        } else {
            // For all information
            cell.isUserInteractionEnabled = false
        }
        cell.textLabel?.text = breedArray[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            // Creates a ViewController with type WebViewController
            guard let webVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
            // Shares string data with URL
            webVC.urlString = urls[indexPath.row]
            // Presents WebViewController
            let navigationC = UINavigationController()
            navigationC.viewControllers = [webVC]
            present(navigationC, animated: true, completion: nil)
        }
    }

    
}
