//
//  BannerCell.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class BannerCell: UICollectionViewCell {
    
    static let identifire = "TopBannerCell"
    
    private let cornerRadius: CGFloat = 10
    
    private let bannerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setViewHierarhies()
        setupConstraints()
        setupShadowCell()
        self.bannerImage.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies(){
        contentView.addSubview(bannerImage)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bannerImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bannerImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupView() {
        bannerImage.layer.cornerRadius = cornerRadius
    }
    
    private func setupShadowCell() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.cornerRadius = cornerRadius
    }
    
    func configure(with model: UIImage) {
        self.bannerImage.image = model
    }
}
