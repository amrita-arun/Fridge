//
//  User.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    
    var name: String
    var username: String
    var groceryList = GroceryList()
    var recipeList: [Recipe] = []
    var pantry: [Ingredient] = []
}
