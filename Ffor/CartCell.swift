//
//  CartCell.swift
//  Ffor
//
//  Created by Triveni Ashok Naik on 4/30/17.
//  Copyright © 2017 Triveni Ashok Naik. All rights reserved.
//


import UIKit
class CartCell : UITableViewCell {
    
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var valueLabel: UILabel!
    
    @IBOutlet var quantityLabel: UILabel!
    
    @IBAction func stepperClicked(sender: UIStepper) {
        
        let quantity = Int(sender.value)
        quantityLabel.text = String(quantity)
        
    }
    
    
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
    }
    
    
}
