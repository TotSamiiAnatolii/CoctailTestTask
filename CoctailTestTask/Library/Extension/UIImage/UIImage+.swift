//
//  UIImage+.swift
//  CoctailTestTask
//
//  Created by APPLE on 06.08.2023.
//

import UIKit

extension UIImage {
    
    func resize(newSize: CGSize, retina: Bool = true) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(
            newSize,
            false,
            retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
