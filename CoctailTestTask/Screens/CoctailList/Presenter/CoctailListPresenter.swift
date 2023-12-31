//
//  CoctailListPresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol CoctailListPresenterProtocol: AnyObject {
    
    init(coctailAPIManager: CoctailAPIManagerProtocol, router: RouterProtocol)
    
    func viewDidLoad()
    
    func getCategories(completion: @escaping ([ModelCategory])->Void)
    
    func getMenuList(categories: [ModelCategory])
    
    func updateStateDragging(state: StateScroll)
    
    func setViewState(state: CoctailListViewState)
    
    func showCoctail(id: String)
}

final class MenuPresenter: CoctailListPresenterProtocol {
   
    weak var view: CoctailListViewProtocol?
    
    private let coctailAPIManager: CoctailAPIManagerProtocol
    
    private let router: RouterProtocol
    
    private let mapper = CoctailMapper()
    
    private var stateView: CoctailListViewState = .loading {
        didSet {
            setViewState(state: stateView)
        }
    }
    
    init(coctailAPIManager: CoctailAPIManagerProtocol, router: RouterProtocol) {
        self.coctailAPIManager = coctailAPIManager
        self.router = router
    }

    func getCategories(completion: @escaping ([ModelCategory])->Void) {
        
        coctailAPIManager.getCategory { category in
            switch category {
            case .success(let success):
                self.stateView = .loadCategory(self.mapper.map(models: success.drinks))
                completion(self.mapper.map(models: success.drinks))
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func getMenuList(categories: [ModelCategory]) {
        
        coctailAPIManager.getMenuList(categories: categories) {result in
            switch result {
            case .success(let success):
                
                let photo = (success[categories[0].name]?.drinks
                    .compactMap{URL(string: $0.strDrinkThumb)})
                
                photo?.forEach { url in
                    ImageDownloader.shared.warmCache(with: url)
                }
                DispatchQueue.main.async {
                    self.stateView = .papulated(self.mapper.mapListMenu(model: success))
                }
            case .failure(let failure):
                self.stateView = .error(failure)
            }
        }
    }
    func viewDidLoad() {
        stateView = .loading
        getCategories { categories in
            self.getMenuList(categories: categories)
        }
    }
    
    func updateStateDragging(state: StateScroll) {
        view?.stateScroll = state
    }
    
    func showCoctail(id: String) {
        router.showDetail(id: id)
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
        case .loadCategory(let categories):
            view?.categories(models: categories)
        }
    }
}

