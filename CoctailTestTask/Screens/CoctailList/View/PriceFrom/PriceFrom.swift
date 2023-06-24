//
//  PriceFrom.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class PriceFrom: UIView {
    
    private let priceFromLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 1,
                    textAlignment: .center,
                    font: Fonts.priceFrom)
        .setTextColor(color: Colors.priceFrom)
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 5
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.priceFrom.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(priceFromLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceFromLabel.topAnchor.constraint(equalTo: self.topAnchor),
            priceFromLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priceFromLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            priceFromLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
extension PriceFrom: ConfigurableView {
    func configure(with model: ModelPriceFrom) {
        self.priceFromLabel.text = model.price
    }
    
    typealias Model = ModelPriceFrom
}
