//
//  DetailTableView.swift
//  Сats
//
//  Created by Головаш Анастасия on 15.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

protocol DetailTableViewDelegate {
    /**
     Sets title if it needed.
     - Parameters:
        - needSetTitle: true if title needed.
     */
    func setTitle(_ needSetTitle: Bool)
}

class DetailTableView: UITableView {
    // Delegate
    var detailTableViewDelegate: DetailTableViewDelegate?
    // Variables
    var imageViewHeight: NSLayoutConstraint?
    var imageViewBottom: NSLayoutConstraint?
    var isSetTitle: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Sets variables values
        guard let header = tableHeaderView else { return }
        if let catImageView = header.subviews.first as? UIImageView {
            imageViewHeight = catImageView.constraints.filter{ $0.identifier == "imageViewHeight" }.first
            imageViewBottom = constraints.filter{ $0.identifier == "imageViewBottom" }.first
        }
        
        let offsetY = -contentOffset.y
        
        // Parallax effect
        imageViewBottom?.constant = offsetY >= 0 ? 0 : offsetY / 2
        imageViewHeight?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        header.clipsToBounds = offsetY <= 0
    
        // Tells to detailTableViewDelegate whether a title is required
        if (offsetY > -263.0) && isSetTitle {
            isSetTitle = false
            detailTableViewDelegate?.setTitle(false)
        } else if (offsetY < -263.0) && !isSetTitle {
            isSetTitle = true
            detailTableViewDelegate?.setTitle(true)
        }
    }

}
