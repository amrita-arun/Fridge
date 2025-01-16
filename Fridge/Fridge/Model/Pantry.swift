//
//  Pantry.swift
//  Fridge
//
//  Created by Administrator on 1/1/25.
//

import Foundation

struct Pantry: Identifiable {
    let id = UUID()
    
    var ingredients: [Ingredient] = []
}
