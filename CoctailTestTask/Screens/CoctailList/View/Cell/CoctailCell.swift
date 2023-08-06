//
//  MenuCell.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class CoctailCell: UICollectionViewCell {
    
    static let identifire = "MenuCell"
    
    private let indentRight: CGFloat = 24
    
     let productImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = Colors.mainBackGroundColor
        return image
    }()
 
    private let nameProductLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 0,
                    textAlignment: .left,
                    font: Fonts.citySelection)
        .setTextColor(color: Colors.textColor)
    
    private let productDescriptionLabel: UILabel = UILabel()
        .setMyStyle(numberOfLines: 0,
                    textAlignment: .left,
                    font: Fonts.productDescription)
        .setTextColor(color: Colors.textColor)

     let priceFromView: PriceFrom = PriceFrom()

     let stackView: UIStackView = UIStackView()
        .myStyleStack(spacing: 8,
                      alignment: .fill,
                      axis: .vertical,
                      distribution: .fill,
                      userInteraction: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarhies()
        setupConstraints()
//        contentView.backgroundColor = Colors.mainBackGroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(productImage)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameProductLabel)
        stackView.addArrangedSubview(productDescriptionLabel)
        contentView.addSubview(priceFromView)
    }

    private func setupConstraints() {
      
        NSLayoutConstraint.activate([
            productImage.widthAnchor.constraint(equalToConstant: 132),
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: productImage.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indentRight),
        ])
        
        NSLayoutConstraint.activate([
            priceFromView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indentRight),
            priceFromView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            priceFromView.widthAnchor.constraint(equalToConstant: 87),
            priceFromView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func animate() {
        productImage.transform = .init(scaleX: 0.9, y: 0.9)
        stackView.transform = .init(scaleX: 0.9, y: 0.9)
        priceFromView.transform = .init(scaleX: 0.9, y: 0.9)
//        var constraint: NSLayoutConstraint?
//        constraint = productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
//        constraint?.isActive = true
//        constraint?.constant += 20
//        UIView.animate(
//            withDuration: 0.8,
//            delay: 0,
//            usingSpringWithDamping: 0.5,
//            initialSpringVelocity: 0.5,
//            options: .curveEaseIn,
//            animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
    }
}
extension CoctailCell: ConfigurableView {
    func configure(with model: ModelCoctailCell) {
//        self.productImage.image = model.productImage
        self.productImage.image = Images.noPhoto
        self.nameProductLabel.text = model.nameProduct
        self.productDescriptionLabel.text = model.productDescription
        self.priceFromView.configure(with: ModelPriceFrom())
    }
    
    typealias Model = ModelCoctailCell
}
