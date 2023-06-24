//
//  ConfigurableView.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import Foundation

protocol ConfigurableView {
    associatedtype Model
    
    func configure(with model: Model)
}
