//
//  CoctailMapper.swift
//  CoctailTestTask
//
//  Created by APPLE on 30.07.2023.
//

import UIKit

protocol Mapper {
    
    associatedtype InputType
    associatedtype OutputType
    
    func mapCategories(model: InputType) -> OutputType
    
}
extension Mapper {
    
    func map(models: [InputType]) -> [OutputType] {
        models.map(mapCategories)
    }
}

final class CoctailMapper: Mapper {
    
    func mapCategories(model: DrinkCategories) -> ModelCategory {
        ModelCategory(name: model.strCategory, isSelected: false)
    }
    
    func mapListMenu(model: [String: CocktailResponse]) -> [String: [ModelCoctailCell]] {
        
        var cocktail: [String: [ModelCoctailCell]] = [:]
        
        model.forEach { key, value in
            cocktail[key] = value.drinks.map({ Drink in
                return ModelCoctailCell(productImage: Drink.strDrinkThumb + "/preview",
                                        nameProduct: Drink.strDrink,
                                        id: Drink.idDrink)
            })
        }
        return cocktail
    }
}

final class DetailMapper: Mapper {
    
    func mapCategories(model: Cocktails) -> ModelDetailDrinkView {
        ModelDetailDrinkView(
            productPhoto: model.drinks.first!.strDrinkThumb,
            ingredients: model.drinks.first!.ingredients,
            name: model.drinks.first!.strDrink,
            instructions: model.drinks.first!.strInstructions!)
        
    }
}
