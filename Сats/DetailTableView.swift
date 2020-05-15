//
//  DetailTableView.swift
//  Сats
//
//  Created by Головаш Анастасия on 15.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class DetailTableView: UITableView {

    var imageViewHeight: NSLayoutConstraint?
    var imageViewBottom: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        if let catImageView = header.subviews.first as? UIImageView {
            imageViewHeight = catImageView.constraints.filter{ $0.identifier == "imageViewHeight" }.first
            imageViewBottom = constraints.filter{ $0.identifier == "imageViewBottom" }.first
        }
        let offsetY = -contentOffset.y
        imageViewBottom?.constant = offsetY >= 0 ? 0 : offsetY / 2
        imageViewHeight?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        header.clipsToBounds = offsetY <= 0
    }

}
