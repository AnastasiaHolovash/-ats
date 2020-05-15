//
//  ServerManager.swift
//  Сats
//
//  Created by Головаш Анастасия on 13.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

func postAndGetData(url: String, complition: @escaping (Data) -> ()) {
    
    let url = URL(string: url)!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "a1c2bc18-dc1f-42e9-8795-43ad64d9cf4f")

    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        
        if (error != nil) {
            print(error ?? "")
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse ?? "")
        }
        
        if let data = data {
            complition(data)
        }
    
    })
    dataTask.resume()
}

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        var imageStringUrl: String?
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: self.center.x, y: self.center.y * 2.5)
        
        // if not, download image from url
        postAndGetData(url: urlString) { data in
            let dataString = String(data: data, encoding: .utf8)
            print(dataString ?? "")
            if let breedsWithImage = try? JSONDecoder().decode([ImageAnsver].self, from: data) {
                imageStringUrl = breedsWithImage[0].url
            }
            if let imageUrl = URL(string: imageStringUrl ?? "") {
                
                URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data!) {
                            imageCache.setObject(image, forKey: urlString as NSString)
                            self.image = image
                            activityIndicator.removeFromSuperview()
                        }
                    }
                }).resume()
            }
        }
    }
    
}

