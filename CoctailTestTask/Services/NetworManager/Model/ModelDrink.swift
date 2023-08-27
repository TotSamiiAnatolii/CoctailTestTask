//
//  ModelDrink.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

struct ResultDTO {
    
    let model: [String: DTO]
}

struct DTO {
    let strDrink: String
    var strDrinkThumb: String {
        didSet {
            strDrinkThumb = strDrinkThumb + "/preview"
        }
    }
    let idDrink: String
    let detail: Cocktails
}

struct CocktailResponse: Codable {
    public let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    var strDrinkThumb: String {
        didSet {
            strDrinkThumb = strDrinkThumb + "/preview"
        }
    }
    let idDrink: String
}
