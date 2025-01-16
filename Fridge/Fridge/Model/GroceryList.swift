//
//  GroceryList.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import Foundation

struct GroceryList: Identifiable {
    let id = UUID()
    
    var ingredients: [Ingredient] = []
    var totalCost = 0
}
