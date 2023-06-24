//
//  ModelDrink.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

struct CocktailResponse: Codable {
    public  let drinks: [Drink]
}

struct Drink: Codable {
    public let strDrink: String
    public let strDrinkThumb: String
    public let idDrink: String
}
