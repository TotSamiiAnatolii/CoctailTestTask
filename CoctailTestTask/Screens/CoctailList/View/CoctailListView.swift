//
//  CoctailListView.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class CoctailListView: UIView {
    
    var collectionView: UICollectionView!
    
    private let heightCityButton: CGFloat = 20
    
    private let heightNavBar: CGFloat = 100
    
    private let indent: CGFloat = 20
        
    public let indicatorDownloads: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    public let navBarView: UIView = UIView()
        .setStyle(color: Colors.mainBackGroundColor)
    
    private let cityButton = CitySelectionButton()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCollectionView()
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = CollectionMainLyout()
        layout.minimumLineSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Colors.mainBackGroundColor
        
        collectionView.register(SelectCategoryCell.self, forCellWithReuseIdentifier: SelectCategoryCell.identifire)
        collectionView.register(TopBannerCell.self, forCellWithReuseIdentifier: TopBannerCell.identifire)
        collectionView.register(CoctailCell.self, forCellWithReuseIdentifier: CoctailCell.identifire)
        collectionView.register(CategoryHeader.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: CategoryHeader.identifire)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "CategoryHeader.identifire")
    }
    
    private func setupView() {
        self.backgroundColor = .white
    }
    
    private func setViewHierarhies() {
        self.addSubview(navBarView)
        self.addSubview(cityButton)
        self.addSubview(collectionView)
        self.addSubview(indicatorDownloads)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            navBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBarView.topAnchor.constraint(equalTo: self.topAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: heightNavBar)
        ])
        
        NSLayoutConstraint.activate([
            cityButton.heightAnchor.constraint(equalToConstant: heightCityButton),
            cityButton.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -indent),
            cityButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: indent)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cityButton.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorDownloads.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicatorDownloads.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
extension CoctailListView: ConfigurableView {
    func configure(with model: ModelMenuView) {
        cityButton.configure(with: model.nameCity)
    }
    
    typealias Model = ModelMenuView
}

