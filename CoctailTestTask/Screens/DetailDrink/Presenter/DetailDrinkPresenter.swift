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
    
    private let networkService: NetworkServiceProtocol
    
    private let router: RouterProtocol
    
    weak var view: DetailDrinkViewProtocol?
    
    init(id: String, netwokService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = netwokService
        self.router = router
        getDetailDrink(id: id)
    }
        
    func getDetailDrink(id: String) {
        networkService.getDetailDrink(id: id) {result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
