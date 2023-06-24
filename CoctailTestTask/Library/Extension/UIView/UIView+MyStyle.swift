//
//  UIView+MyStyle.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

extension UIView {

    public func setStyle(color: UIColor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
        return self
    }
    
    public func setRoundCorners(radius: CGFloat) -> Self {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        return self
    }
    
    public func setShadows(color: CGColor, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float ) -> Self {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                          y: bounds.maxY - layer.shadowRadius,
                                                          width: bounds.width,
                                                          height: layer.shadowRadius)).cgPath
        return self
    }
}
