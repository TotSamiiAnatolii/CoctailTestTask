//
//  NetworkManager.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
    
    func getMenuList(categories: [ModelCategory], comletion: @escaping([String: [ModelCoctailCell]]) -> Void)
    
    func getDetailDrink(id: String, completion: @escaping(ModelDetailDrink) -> Void)
}

final class NetworkManager: NetworkServiceProtocol {
    
    func getDetailDrink(id: String, completion: @escaping (ModelDetailDrink) -> Void) {
        let urlString = ApiUrl.list.rawValue + id
        
        let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: newUrl) else {
            print("Error")
            return
        }
        fetchModels(from: url, in: completion)
    }

    private let groupMenuList = DispatchGroup()
    
    private let groupImage = DispatchGroup()
    
    func getMenuList(categories: [ModelCategory], comletion: @escaping([String: [ModelCoctailCell]]) -> Void) {
        
        var listMenu: [String: [ModelCoctailCell]] = [:]
        
        categories.forEach { category in
            
            self.groupMenuList.enter()
            fetchList(for: category.name) { list in
                self.getImage(category: [category.name: list]) { image in
                    
                    listMenu[category.name] = image
                    self.groupMenuList.leave()
                }
            }
        }
        groupMenuList.notify(queue: .main) {
            comletion(listMenu)
        }
    }
    
    func getImage(category: [String: CocktailResponse], completion: @escaping ([ModelCoctailCell]) -> Void) {
        
        var modelMenuCell: [ModelCoctailCell] = []
        
        category.forEach {key, value in
            value.drinks.forEach({ drink in
                groupImage.enter()
              
                DispatchQueue.global(qos: .userInteractive).async {
                    let imageData = try? Data(contentsOf: URL(string: drink.strDrinkThumb)!)
                    let image = UIImage(data: imageData ?? Data()) ?? UIImage()
                    
                    DispatchQueue.main.async {
                        modelMenuCell.append(ModelCoctailCell(productImage: image, nameProduct: drink.strDrink))
                        self.groupImage.leave()
                    }
                }
            })
        }
        groupImage.notify(queue: .main) {
            completion(modelMenuCell)
        }
    }
    
    func fetchList(for category: String, completion: @escaping (CocktailResponse) -> Void) {
        let urlString = ApiUrl.list.rawValue + category
        
        let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: newUrl) else {
            print("Error")
            return
        }
        fetchModels(from: url, in: completion)
    }

    private func fetchModels<T: Decodable>(from url: URL, in completion: @escaping ((T) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }

            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(model)
                }
            }
            catch {
                print("decode error")
            }
        }.resume()
    }
    
    private func fetchModels2<T: Decodable>(from url: URL, in completion: @escaping ((Result<T, Error>) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            }
            catch {
                print("decode error")
            }
        }.resume()
    }
}

