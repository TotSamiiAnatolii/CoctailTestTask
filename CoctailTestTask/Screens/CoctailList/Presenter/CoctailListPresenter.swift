//
//  CoctailListPresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol CoctailListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol)
    
    var categories: [ModelCategory] { get set }

    func viewDidLoad()
    
    func getMenuList(categories: [ModelCategory])
    
    func updateStateDragging(state: StateScroll)
    
    func setViewState(state: CoctailListViewState)
}

final class MenuPresenter: CoctailListPresenterProtocol {
  
    weak var view: CoctailListViewProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    private var stateView: CoctailListViewState = .loading {
        didSet {
            setViewState(state: stateView)
        }
    }
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    var categories: [ModelCategory] = [ModelCategory(name: Category.coffeeTea.name, isSelected: true),
                                       ModelCategory(name: Category.shot.name, isSelected: false),
                                       ModelCategory(name: Category.beer.name, isSelected: false),
                                       ModelCategory(name: Category.shake.name, isSelected: false)]

    func getMenuList(categories: [ModelCategory]) {
//        networkService.getMenuList(categories: categories) {result in
//
//            switch result {
//            case .success(let success):
//                DispatchQueue.main.async {
//                    self.stateView = .papulated(success)
//                }
//            case .failure(let failure):
//                self.stateView = .error(failure)
//            }
//          
//        }
        networkService.getCategory { category in
            switch category {
            case .success(let success):
                success.drinks.forEach { category in
                    print(category.strCategory)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func viewDidLoad() {
        stateView = .loading
        getMenuList(categories: categories)
    }
    
    func updateStateDragging(state: StateScroll) {
        view?.stateScroll = state
    }
    
    func setViewState(state: CoctailListViewState) {
        switch state {
        case .loading:
            view?.setIndicatorDownload(state: .loading)
        case .papulated(let listCoctail):
            view?.setIndicatorDownload(state: .downloadFinished)
            view?.succes(models: listCoctail)
        case .error(let error):
            view?.failure(error: error)
        }
    }
}

