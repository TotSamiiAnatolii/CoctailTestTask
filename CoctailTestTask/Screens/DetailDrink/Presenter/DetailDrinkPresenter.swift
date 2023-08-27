//
//  DetailDrinkPresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import Foundation

protocol DetailDrinkPresenterProtocol: AnyObject {
    
    func getDetailDrink(id: String)

}

final class DetailDrinkPresenter: DetailDrinkPresenterProtocol {
    
    private let coctailAPIManager: CoctailAPIManagerProtocol
    
    private let router: RouterProtocol
    
    weak var view: DetailDrinkViewProtocol?
    
    init(id: String, coctailAPIManager: CoctailAPIManagerProtocol, router: RouterProtocol) {
        self.coctailAPIManager = coctailAPIManager
        self.router = router
        getDetailDrink(id: id)
    }
        
    func getDetailDrink(id: String) {
        coctailAPIManager.getDetailDrink(id: id) {result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
