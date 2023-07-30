//
//  ModelMenuView.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import Foundation

struct ModelMenuView {
    
    let nameCity: String = "Москва"
}

enum CoctailListViewState {
    case loading
    case papulated([String: [ModelCoctailCell]])
    case error(Error)
}
