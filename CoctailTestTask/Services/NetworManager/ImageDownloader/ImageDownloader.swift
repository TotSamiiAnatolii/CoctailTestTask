//
//  ImageDownloader.swift
//  CoctailTestTask
//
//  Created by APPLE on 06.08.2023.
//

import Foundation
import UIKit

protocol ImageDownLoaderProtocol {
    
    func getImage(for url: String, completion: @escaping (UIImage) -> Void, useCash: Bool)
    
    
}

final class ImageDownloader: ImageDownLoaderProtocol {
    
    static let shared = ImageDownloader()
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    private let imageDownLoadQueue = DispatchQueue.global(qos: .userInitiated)
    
    func warmCache(with url: URL, copletion: @escaping () -> Void = {}) {
        
        imageDownLoadQueue.async {
            guard let image = try? Data(contentsOf: url) else {
                return
            }
            
            let image1 = UIImage(data: image)!.copy(newSize: CGSize(width: 150, height: 150))!
            DispatchQueue.main.async {
                self.imageCache.setObject(image1 as UIImage, forKey: url as NSURL)
            }
//            self.imageCache.setObject(image as NSData, forKey: url as NSURL)
        }
    }
    
    func getImage(for url: String, completion: @escaping (UIImage) -> Void, useCash: Bool) {
        
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        if let data = imageCache.object(forKey: imageUrl as NSURL) {
            completion(data as UIImage)
            return
        }
        
        imageDownLoadQueue.async {
            
            let imageData = try? Data(contentsOf: imageUrl)
            let image = UIImage(data: imageData!)!.copy(newSize: CGSize(width: 150, height: 150))!
//            self.getImage1(for: imageUrl) { data in
                
            DispatchQueue.main.async {
                self.imageCache.setObject(image as UIImage, forKey: imageUrl as NSURL)
            }
            
                
            completion(image)
//            }
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
