//
//  ModelCategory.swift
//  CoctailTestTask
//
//  Created by APPLE on 30.07.2023.
//

import Foundation

struct Categories: Codable {
    let drinks: [DrinkCategories]
}

struct DrinkCategories: Codable {
    let strCategory: String
}
