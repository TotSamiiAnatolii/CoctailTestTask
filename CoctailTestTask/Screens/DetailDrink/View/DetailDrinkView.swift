//
//  DetailDrinkView.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class DetailDrinkView: UIView {
    
    private let productImage: UIImageView = UIImageView()
        .setMyStyle()
        .setImage(image: Images.placeholder)
    
    private let nameCocktailLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 2,
                    textAlignment: .center,
                    font: UIFont.systemFont(ofSize: 22))
        .setTextColor(color: .black)
    
    private let ingredientLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 1,
                    textAlignment: .left,
                    font: UIFont.systemFont(ofSize: 15))
    
    private let measureLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 1,
                    textAlignment: .left,
                    font: UIFont.systemFont(ofSize: 15))
    
    private let ingredientMeasureStack = UIStackView()
        .myStyleStack(spacing: 3,
                      alignment: .center,
                      axis: .horizontal,
                      distribution: .fill,
                      userInteraction: false)
        .setLayoutMargins(top: 5,
                          left: 5,
                          bottom: 5,
                          right: 5)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        addSubview(productImage)
        addSubview(nameCocktailLabel)
        addSubview(ingredientMeasureStack)
        ingredientMeasureStack.addArrangedSubview(ingredientLabel)
        ingredientMeasureStack.addArrangedSubview(measureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            productImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            nameCocktailLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10),
            nameCocktailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameCocktailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ingredientMeasureStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ingredientMeasureStack.topAnchor.constraint(equalTo: nameCocktailLabel.bottomAnchor, constant: 10)
        ])
    }
}
extension DetailDrinkView: ConfigurableView {
    
    typealias Model = ModelDetailDrinkView
    
    func configure(with model: ModelDetailDrinkView) {
        nameCocktailLabel.text = "410 Gone"
        ingredientLabel.text = "Gin tonic"
        measureLabel.text = "1/5"
    }
}
