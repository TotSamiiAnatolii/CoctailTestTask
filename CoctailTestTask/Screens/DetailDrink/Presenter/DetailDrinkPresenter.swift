//
//  DetailDrinkPresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import Foundation

protocol DetailDrinkPresenterProtocol: AnyObject {
    
    func getDetailDrink()
    
    var detailDrink: ModelDetailDrink? { get set }
}

final class DetailDrinkPresenter: DetailDrinkPresenterProtocol {
    
    let networkService: NetworkServiceProtocol
    
    weak var view: DetailDrinkViewProtocol?
    
    init(netwokService: NetworkServiceProtocol) {
        self.networkService = netwokService
    }
    
    var detailDrink: ModelDetailDrink?
    
    func getDetailDrink() {
        networkService.getDetailDrink(id: "") {[weak self] detailDrink in
            
        }
    }
}
