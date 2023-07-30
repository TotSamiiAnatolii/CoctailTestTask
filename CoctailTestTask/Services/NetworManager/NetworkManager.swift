//
//  NetworkManager.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
    
    func getMenuList(categories: [ModelCategory], completion: @escaping(Result<[String: [ModelCoctailCell]], Error>) -> Void)
    
    func getDetailDrink(id: String, completion: @escaping(ModelDetailDrink) -> Void)
    
    func getCategory(completion: @escaping(Result<Categories, Error>) -> Void)
}

final class NetworkManager: NetworkServiceProtocol {
    
    func getDetailDrink(id: String, completion: @escaping (ModelDetailDrink) -> Void) {
        //        let urlString = ApiUrl.list.rawValue + id
        //
        //        let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        //        guard let url = URL(string: newUrl) else {
        //            print("Error")
        //            return
        //        }
        //        fetchModels(from: url, in: completion)
    }
    
    private let groupMenuList = DispatchGroup()
    
    private let groupImage = DispatchGroup()
    
    func getMenuList(categories: [ModelCategory], completion: @escaping (Result<[String: [ModelCoctailCell]], Error>) -> Void) {
        
        var listMenu: [String: [ModelCoctailCell]] = [:]
        
        categories.forEach { category in
            
            self.groupMenuList.enter()
            fetchList(for: category.name) { result in
                switch result {
                case .success(let success):
                    self.getImage(category: [category.name: success]) { image in
                        
                        listMenu[category.name] = image
                        self.groupMenuList.leave()
                    }
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
        groupMenuList.notify(queue: .main) {
            completion(.success(listMenu))
        }
    }
    
    func getImage(category: [String: CocktailResponse], completion: @escaping ([ModelCoctailCell]) -> Void) {
        
        var modelMenuCell: [ModelCoctailCell] = []

        category.forEach {key, value in
            value.drinks.forEach({ drink in
                groupImage.enter()

                DispatchQueue.global(qos: .userInitiated).async {
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
    
    func getImage2(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        var image = UIImage()
        
//        category.forEach {key, value in
//            value.drinks.forEach({ drink in
                groupImage.enter()
                
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = try? Data(contentsOf: URL(string: url)!)
                    image = UIImage(data: imageData ?? Data()) ?? UIImage()
                    
//                    DispatchQueue.main.async {
//                        modelMenuCell.append(ModelCoctailCell(productImage: image, nameProduct: drink.strDrink))
                        self.groupImage.leave()
//                    }
                }
//            })
//        }
        groupImage.notify(queue: .main) {
            completion(.success(image))
        }
    }
    
    func fetchList(for category: String, completion: @escaping (Result<CocktailResponse, Error>) -> Void) {
        guard let url = API.fetchCategory(category: category) else {
            return
        }
        fetchModels(from: url, in: completion)
    }
    
    func getCategory(completion: @escaping(Result<Categories, Error>) -> Void) {
        guard let url = API.categories else {
            return
        }
        fetchModels(from: url, in: completion)
    }
    
    private func fetchModels<T: Decodable>(from url: URL, in completion: @escaping ((Result<T, Error>) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                print(data)
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

