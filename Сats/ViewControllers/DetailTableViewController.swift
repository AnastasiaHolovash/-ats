//
//  DetailTableViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 13.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    public var breed: CatBreed?
    private var breedArray: [[String]] = [[], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = breed?.name
        createBreedArray()
        setImage()
        headerView.set = catImageView.heightAnchor
    }
    
    func setImage() {
        if let breed = breed {
            let breedId = breed.id
            catImageView.loadImageUsingCache(withUrl: "https://api.thecatapi.com/v1/images/search?breed_id=\(breedId)")
        }
    }
    
    func createBreedArray() {
        if let breed = breed {
//            breedArray.append([])
            breedArray[0].append("id: \(breed.id)")
            breedArray[0].append("name: \(breed.name)")
            breedArray[1].append("cfaURL: \(String(describing: breed.cfaURL))")
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
            breedArray[0].append("bidability: \(String(describing: breed.bidability))")
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

        cell.textLabel?.text = breedArray[indexPath.section][indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
