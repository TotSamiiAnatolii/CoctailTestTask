//
//  DetailDrinkView.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class DetailDrinkView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DetailDrinkView: ConfigurableView {
    
    typealias Model = ModelDetailDrinkView
    
    func configure(with model: ModelDetailDrinkView) {
        
    }
}
