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
        image.contentMode = .scaleAspectFit
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? touchDown() : touchUp()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        nameProductLabel.text = nil
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
    
    private func touchDown() {
        let scaleX = 0.98
        let scaleY = 0.98
    
        transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    private func  touchUp() {
        let scaleX = 1.0
        let scaleY = 1.0
        
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }
}
extension CoctailCell: ConfigurableView {
    
    typealias Model = ModelCoctailCell
    
    func configure(with model: ModelCoctailCell) {
        self.productImage.setImageURL(for: model.productImage, placeholder: Images.placeholder)
        self.nameProductLabel.text = model.nameProduct
        self.priceFromView.configure(with: ModelPriceFrom())
    }
}
