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
    
    private let nameCocktailLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 2,
                    textAlignment: .center,
                    font: UIFont.systemFont(ofSize: 22))
        .setTextColor(color: .black)
    
    private let ingredientMeasureStack = UIStackView()
        .myStyleStack(spacing: 3,
                      alignment: .fill,
                      axis: .vertical,
                      distribution: .fill,
                      userInteraction: false)
        
        
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
    
    private func prepareIngredientStack(ingredients: [String]) {
       
        ingredients.forEach { ingredient in
            let ingredientLabel: UILabel = UILabel()
                .setMyStyle(numberOfLines: 1,
                            textAlignment: .left,
                            font: UIFont.systemFont(ofSize: 15))
            ingredientLabel.text = ingredient
            ingredientMeasureStack.addArrangedSubview(ingredientLabel)
        }
    }
}
extension DetailDrinkView: ConfigurableView {
    
    typealias Model = ModelDetailDrinkView
    
    func configure(with model: ModelDetailDrinkView) {
        productImage.setImageURL(for: model.productPhoto, placeholder: Images.placeholder)
        nameCocktailLabel.text = model.name
        prepareIngredientStack(ingredients: model.ingredients)
    }
}
