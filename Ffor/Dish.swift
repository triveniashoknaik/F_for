//
//  Dish.swift
//  TestProj
//
//  Created by Triveni Ashok Naik on 4/25/17.
//  Copyright © 2017 Nishant Agrawal. All rights reserved.
//

import Foundation

class Dish: NSObject {
    var name: String
    var valueInDollars: Double
    
    //designated intializer
    init(name: String, valueInDollars: Double) {
        self.name = name
        self.valueInDollars = valueInDollars
        
        super.init()
    }
    
    //convenience initializer
    convenience init(random: Bool) {
        if random {
            let adjectives = ["Chicken", "Mexican", "Veg", "American", "Italian", "Cheese", "Potato", "Chinese"]
            let nouns = ["Sandwich", "Noodles", "Kebab", "Chops", "Pizza", "Fried Rice", "Fries", "Burger","Quesadilla", "Salad", "Pasta"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = randomAdjective + " " + randomNoun
            let randomValue = Double(arc4random()) / Double(UINT32_MAX) * abs(4.00 - 12.50) + min(4.00, 12.50)
            let doubleStr = String(format: "%.2f", randomValue)
            let randomValue2 = Double(doubleStr)
            
            self.init(name: randomName, valueInDollars: randomValue2!)
        }
        else {
            self.init(name: "", valueInDollars: 0)
        }
    }
    
    func randomBetweenNumbers(firstNum: Double, secondNum: Double) -> Double{
        return Double(arc4random()) / Double(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
