//
//  Recipe.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    
    var name = ""
    var totalCost = 0
    var ingredients: [Ingredient] = []
}
