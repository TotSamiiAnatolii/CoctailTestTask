//
//  DetailDrinkView.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class DetailDrinkView: UIView {
    
    private let scrollView: UIScrollView = {
        let scView = UIScrollView()
        scView.translatesAutoresizingMaskIntoConstraints = false
        scView.showsVerticalScrollIndicator = true
        return scView
    }()
    
    private let mainStack = UIStackView()
        .myStyleStack(spacing: 3,
                      alignment: .fill,
                      axis: .vertical,
                      distribution: .equalSpacing,
                      userInteraction: false)
    
    private let productImage: UIImageView = UIImageView()
        .setMyStyle()
        .setRoundCorners(radius: 15)
        .roundCorners([.bottomRight, .bottomLeft], radius: 15)
    
    private let nameCocktailLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 2,
                    textAlignment: .left,
                    font: UIFont.systemFont(ofSize: 22))
        .setTextColor(color: .black)
    
    private let ingredientsLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 2,
                    textAlignment: .left,
                    font: UIFont.systemFont(ofSize: 17, weight: .semibold))
        .setTextColor(color: .black)
    
    private let instructionsLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 0,
                    textAlignment: .left,
                    font: UIFont.systemFont(ofSize: 16))
        .setTextColor(color: .black)
    
    private let instructionsTitleLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 0,
                    textAlignment: .left,
                    font: UIFont.systemFont(ofSize: 17, weight: .semibold))
        .setTextColor(color: .black)
    
    private let descriptionStack = UIStackView()
        .myStyleStack(spacing: 10,
                      alignment: .fill,
                      axis: .vertical,
                      distribution: .fill,
                      userInteraction: false)
        .setLayoutMargins(top: 15, left: 20, bottom: 10, right: 20)
    
    private let ingredientMeasureStack = UIStackView()
        .myStyleStack(spacing: 3,
                      alignment: .fill,
                      axis: .vertical,
                      distribution: .fill,
                      userInteraction: false)
    
    private let instructionsStack = UIStackView()
        .myStyleStack(spacing: 10,
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
        addSubview(scrollView)
        scrollView.addSubview(mainStack)
        mainStack.addArrangedSubview(productImage)
//        mainStack.addArrangedSubview(nameCocktailLabel)
//        mainStack.addArrangedSubview(ingredientsLabel)
//        mainStack.addArrangedSubview(ingredientMeasureStack)
//        mainStack.addArrangedSubview(instructionsStack)
        
        descriptionStack.addArrangedSubview(nameCocktailLabel)
        descriptionStack.addArrangedSubview(ingredientsLabel)
        descriptionStack.addArrangedSubview(ingredientMeasureStack)
        descriptionStack.addArrangedSubview(instructionsTitleLabel)
        descriptionStack.addArrangedSubview(instructionsStack)
        mainStack.addArrangedSubview(descriptionStack)
//        instructionsStack.addArrangedSubview(instructionsTitleLabel)
        instructionsStack.addArrangedSubview(instructionsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
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
        ingredientsLabel.text = "Ingredients: "
        instructionsTitleLabel.text = "Instruction: "
        instructionsLabel.text = model.instructions
    }
}
