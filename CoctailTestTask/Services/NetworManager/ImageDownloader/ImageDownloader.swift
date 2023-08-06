//
//  ImageDownloader.swift
//  CoctailTestTask
//
//  Created by APPLE on 06.08.2023.
//

import Foundation

protocol ImageDownLoaderProtocol {
    
    func getImage(for url: String, completion: @escaping (Data) -> Void, useCash: Bool)
    
    
}

final class ImageDownloader: ImageDownLoaderProtocol {
    
    static let shared = ImageDownloader()
    
    private var imageCashe = NSCache<NSString, NSData>()
    
    private let imageDownLoadQueue = DispatchQueue.global(qos: .userInitiated)
    
    func getImage(for url: String, completion: @escaping (Data) -> Void, useCash: Bool) {
        
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        if let data = imageCashe.object(forKey: url as NSString) {
            completion(data as Data)
            return
        }
        
        imageDownLoadQueue.async {
            self.getImage1(for: imageUrl) { data in
                
                self.imageCashe.setObject(data as NSData, forKey: url as NSString)
                
                completion(data)
            }
        }
    }
    
    private func getImage1(for url: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Data.self, from: data)
                completion(data)
            }
            catch {
                print("decode error")
            }
        }.resume()
    }
}
