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
     let strDrink: String
     let strDrinkThumb: String
     let idDrink: String
}
