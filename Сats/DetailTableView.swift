//
//  DetailTableView.swift
//  Сats
//
//  Created by Головаш Анастасия on 15.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

protocol DetailTableViewDelegate {
    func setTitle(_ needSetTitle: Bool)
}

class DetailTableView: UITableView {
    
    var mydelegate: DetailTableViewDelegate?

    var imageViewHeight: NSLayoutConstraint?
    var imageViewBottom: NSLayoutConstraint?
    
    var isSetTitle: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        if let catImageView = header.subviews.first as? UIImageView {
            imageViewHeight = catImageView.constraints.filter{ $0.identifier == "imageViewHeight" }.first
            imageViewBottom = constraints.filter{ $0.identifier == "imageViewBottom" }.first
        }
        
        let offsetY = -contentOffset.y
//        print(offsetY)
        if (offsetY > -263.0) && isSetTitle {
            isSetTitle = false
            mydelegate?.setTitle(false)
        } else if (offsetY < -263.0) && !isSetTitle {
            isSetTitle = true
            mydelegate?.setTitle(true)
        }
        
        imageViewBottom?.constant = offsetY >= 0 ? 0 : offsetY / 2
        imageViewHeight?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        header.clipsToBounds = offsetY <= 0
    
    }

}
