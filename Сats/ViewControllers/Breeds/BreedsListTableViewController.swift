//
//  ViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 12.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class BreedsListTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Custom Cell register
        tableView.register(UINib(nibName: "BreedTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BreedTableViewCell")
        
        self.showActivityIndicator()
        
        getData(url: "https://api.thecatapi.com/v1/breeds") { data in
            
            // Uncomment to print all returned data
            
            // let dataString = String(data: data, encoding: .utf8)
            // print(dataString ?? "")
            
            // Casting returned data as CatBreed array
            if let catBreeds = try? JSONDecoder().decode([CatBreed].self, from: data){
                // Sets data to the Singleton
                BreadsManager.shared.breedsArray = catBreeds
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.removeActivityIndicator()
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BreadsManager.shared.breedsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as? BreedTableViewCell else { return UITableViewCell() }
        // Gets one breed by index
        let breed = BreadsManager.shared.breedsArray[indexPath.row]
        // Setup table view cell
        cell.nameLabel.text = breed.name
        cell.detailLabel.text = "Origin: " + breed.origin
        cell.arrowView.isHidden = false
        cell.roundImageView.isHidden = false
        cell.roundColorLabel.isHidden = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Creates a ViewController with type DetailTableViewController
        guard let detailVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailTableViewController") as? DetailTableViewController else { return }
        // Shares one breed data
        detailVC.breed = BreadsManager.shared.breedsArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        // Shows DetailTableViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}


