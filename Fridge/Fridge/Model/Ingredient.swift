//
//  Ingredient.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import Foundation

struct Ingredient: Identifiable {
    let id = UUID()
    
    var name: String
    var price = 0
    var amount = 0
    var unit = "unit"
    var dateBought = ""
}
