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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        detailLabel.text = nil
    }
}
