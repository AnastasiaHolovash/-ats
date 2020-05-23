//
//  BreedTableViewCell.swift
//  Сats
//
//  Created by Головаш Анастасия on 12.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class BreedTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var roundImageView: UIImageView!
    @IBOutlet weak var roundColorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundColorLabel.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        detailLabel.text = nil
        
    }
}
