//
//  ModelDetailDrink.swift
//  CoctailTestTask
//
//  Created by APPLE on 12.08.2023.
//

import Foundation

struct DetailDrinkResponse: Codable {
    let drinks: [[String: String?]]
}

struct Ingredients: Codable {
    
    var listIngredient: [String] = [
        "strIngredient1",
        "strIngredient2",
        "strIngredient3",
        "strIngredient4",
        "strIngredient5",
        "strIngredient6",
        "strIngredient7",
        "strIngredient8",
        "strIngredient9",
        "strIngredient10",
        "strIngredient11",
        "strIngredient12",
        "strIngredient13",
        "strIngredient14",
        "strIngredient15"
    ]
}
