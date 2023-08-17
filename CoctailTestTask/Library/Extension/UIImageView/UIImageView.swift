//
//  UIImageView.swift
//  CoctailTestTask
//
//  Created by APPLE on 06.08.2023.
//

import UIKit

extension UIImageView {
    
    func setImageURL(for url: String, placeholder: UIImage) {
        
        self.image = placeholder
        let urlHash = UUID().hashValue
        tag = urlHash
        
        ImageDownloader.shared.getImage(for: url, completion: { data in
            
            DispatchQueue.global(qos: .userInitiated).async {
                let image = data
                DispatchQueue.main.async {
                    guard self.tag == urlHash else {
                        return
                    }
                    self.image = image
                }
            }
        }, useCash: false)
    }
}
