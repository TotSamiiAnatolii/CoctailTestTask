//
//  ModelDrink.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

struct DTO {
    public var drinks: [Drink]
    public var detail: [[String: String?]]
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
