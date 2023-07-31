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
    
    func map(model: InputType) -> OutputType
    
}
extension Mapper {
    
    func map(models: [InputType]) -> [OutputType] {
        models.map(map)
    }
}

final class CoctailMapper: Mapper {
    
    func map(model: DrinkCategories) -> ModelCategory {
        ModelCategory(name: model.strCategory, isSelected: false)
    }
}
