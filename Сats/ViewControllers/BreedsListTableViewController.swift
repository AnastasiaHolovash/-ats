//
//  ViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 12.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class BreedsListTableViewController: UITableViewController {
    
    private var catBreedsArray: [CatBreed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "BreedTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BreedTableViewCell")
        
        postAndGetData(url: "https://api.thecatapi.com/v1/breeds") { data in
//            let dataString = String(data: data, encoding: .utf8)
//            print(dataString ?? "")
            if let catBreeds = try? JSONDecoder().decode([CatBreed].self, from: data){
                self.catBreedsArray = catBreeds
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catBreedsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as! BreedTableViewCell
        
        let breed = catBreedsArray[indexPath.row]
        cell.nameLabel.text = breed.name
        cell.detailLabel.text = "Origin: " + breed.origin
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let detailVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailTableViewController") as? DetailTableViewController else { return }
        detailVC.breed = self.catBreedsArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}


