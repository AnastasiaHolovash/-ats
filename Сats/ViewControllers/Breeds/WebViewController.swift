//
//  WebViewController.swift
//  Сats
//
//  Created by Головаш Анастасия on 18.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    /// A variable that is shared the the View Controller which presents Web View Controller
    public var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Loading the web page
        if let url = URL(string: urlString ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
            print(url)
        }
    }
    

}
