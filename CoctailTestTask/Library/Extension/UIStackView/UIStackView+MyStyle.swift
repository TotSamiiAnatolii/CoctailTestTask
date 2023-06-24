//
//  UIStackView+MyStyle.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

extension UIStackView {
    
    func myStyleStack(spacing: CGFloat, alignment: UIStackView.Alignment, axis:NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, userInteraction: Bool ) -> Self {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = userInteraction
        return self
    }
    
    func setLayoutMargins(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.isLayoutMarginsRelativeArrangement = true
        return self
    }
}
