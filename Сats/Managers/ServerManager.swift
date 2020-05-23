//
//  ServerManager.swift
//  Сats
//
//  Created by Головаш Анастасия on 13.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

/**
 Gets an array with all breeds of cats from server.
 - Parameters:
    - url: string with URL for request;
    - complition: complition bloc for processing returned data.
 
 - Request http Method: GET.
 - Uses HTTP Header Field.
 */
func getData(url: String, complition: @escaping (Data) -> ()) {
    
    guard let url = URL(string: url) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "a1c2bc18-dc1f-42e9-8795-43ad64d9cf4f")

    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        
        if (error != nil) {
            print(error ?? "")
        } else {
            _ = response as? HTTPURLResponse
        }
        
        if let data = data {
            complition(data)
        }
    
    })
    dataTask.resume()
}


extension UIImageView {
    /**
    Sets pictute to image view.
    - Parameters:
       - urlString: string with URL for get one breed by URL Request;
       - addImageToCache: true if need to add a picture to the cache.
    
    Shows activity indicator while the picture loads.
    */
    func loadImage(withUrl urlString : String, addImageToCache: Bool) {
        var imageStringUrl: String?
        self.image = nil
        
        // Sets activity Indicator
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        if addImageToCache {
            activityIndicator.center = CGPoint(x: self.center.x, y: self.center.y * 2.5)
        } else {
            activityIndicator.center = CGPoint(x: self.center.x, y: self.center.y * 0.5)
        }
        
        // Gets image
        getData(url: urlString) { data in
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
                            if addImageToCache {
                                imageCache.setObject(image, forKey: urlString as NSString)
                            }
                            self.image = image
                            activityIndicator.removeFromSuperview()
                        }
                    }
                }).resume()
            }
        }
    }
        
}

