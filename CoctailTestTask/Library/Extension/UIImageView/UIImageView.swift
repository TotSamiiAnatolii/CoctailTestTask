//
//  UIImageView.swift
//  CoctailTestTask
//
//  Created by APPLE on 06.08.2023.
//

import UIKit

extension UIImageView {
    
    func setImageURL(for url: String, placeholder: UIImage) {
        
        let urlHash = UUID().hashValue
        tag = urlHash
       
        ImageDownloader.shared.getImage(for: url, completion: { data in
            
            DispatchQueue.global(qos: .userInitiated).async {
                
            }
        }, useCash: false)
    }
}
