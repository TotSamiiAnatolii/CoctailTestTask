//
//  CoctailAPIManager.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.08.2023.
//

import Foundation

protocol CoctailAPIManagerProtocol {
    
    func getCategory(completion: @escaping(Result<Categories, Error>) -> Void)
    
    func getMenuList(categories: [ModelCategory], completion: @escaping(Result<[String: CocktailResponse], Error>) -> Void)
    
    func getDetailDrink(id: String, completion: @escaping (Result<Cocktails, Error>) -> Void)
}

final class CoctailAPIManager: CoctailAPIManagerProtocol{
    
    
    private let groupMenuList = DispatchGroup()
    
    private let groupImage = DispatchGroup()
    
    private let networkManager: NetworkServiceProtocol
    
    private let mapper = CoctailMapper()
    
    public init(networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
    }
    
    func getCategory(completion: @escaping(Result<Categories, Error>) -> Void) {
        guard let url = API.categories else {
            return
        }
        networkManager.fetchModels(from: url, in: completion)
    }
    
    func getMenuList(categories: [ModelCategory], completion: @escaping (Result<[String: CocktailResponse], Error>) -> Void) {
        
        var listMenu: [String: CocktailResponse] = [:]
        
        categories.forEach { category in
            
            self.groupMenuList.enter()
            fetchList(for: category.name) { result in
                
                switch result {
                case .success(let success):
                    listMenu[category.name] = success
                    
                case .failure(let failure):
                    print(failure)
                }
                
                self.groupMenuList.leave()
            }
        }
        groupMenuList.notify(queue: .main) {
            completion(.success(listMenu))
        }
    }
    
    func getDetailDrink(id: String, completion: @escaping (Result<Cocktails, Error>) -> Void) {
        guard let url = API.fetchDetailDrink(id: id) else {
            return
        }
        networkManager.fetchModels(from: url, in: completion)
    }
    
    func fetchList(for category: String, completion: @escaping (Result<CocktailResponse, Error>) -> Void) {
        guard let url = API.fetchCategory(category: category) else {
            return
        }
        networkManager.fetchModels(from: url, in: completion)
    }
}
