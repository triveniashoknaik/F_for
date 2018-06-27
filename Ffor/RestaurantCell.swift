//
//  RestaurantCell.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/30/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//

import UIKit
class RestaurantCell : UITableViewCell {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var nameLabel: UILabel!
   
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
    }
    
}
