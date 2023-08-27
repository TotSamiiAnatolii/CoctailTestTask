//
//  NetworkManager.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
    
    func fetchModels<T: Decodable>(from url: URL, in completion: @escaping ((Result<T, Error>) -> Void))
}

final class NetworkManager: NetworkServiceProtocol {
    
    public func fetchModels<T: Decodable>(from url: URL, in completion: @escaping ((Result<T, Error>) -> Void)) {
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
                let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
            }
            catch {
                print(url)
                print(T.self)
                print("decode error")
                completion(.failure(error))
            }
        }.resume()
    }
}

