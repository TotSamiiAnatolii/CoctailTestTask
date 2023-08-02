//
//  UIActivityIndicatorView+.swift
//  CoctailTestTask
//
//  Created by APPLE on 02.08.2023.
//

import UIKit

extension UIActivityIndicatorView {
    
     func controlActivityIndicator(state: StateDowload) {
        switch state {
        case .loading:
            self.isHidden = false
            self.startAnimating()
        case .downloadFinished:
            self.isHidden = true
            self.stopAnimating()
        }
    }
}
