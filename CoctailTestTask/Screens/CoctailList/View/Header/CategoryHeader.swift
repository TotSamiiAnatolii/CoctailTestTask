//
//  CategoryHeader.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class CategoryHeader: UICollectionReusableView {
    
    static let identifire = "CategoryHeader"
    
    private var shadowLayer: CALayer = CALayer()
    
    weak var delegate: ScrollControlDelegate?
    
    private var categories: [String] = [Category.coffeeTea.name, Category.shot.name, Category.beer.name, Category.shake.name]
    
    private var collectionView: UICollectionView!
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Colors.mainBackGroundColor
        collectionView.register(SelectCategoryCell.self, forCellWithReuseIdentifier: SelectCategoryCell.identifire)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout  {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) in
            return Layouts.shared.setCategoryLayoutPanel()
        }
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCollectionView()
        setViewHierarhies()
        setConstraints()
        setStartSelectItem()
        addBottomShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        shadowLayer.isHidden = true
    }
    
    private func setStartSelectItem() {
        collectionView.selectItem(at: IndexPath(row: .zero, section: .zero), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func setViewHierarhies() {
        self.layer.insertSublayer(shadowLayer, at: 0)
        addSubview(collectionView)
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func addBottomShadow()  {
        let pointY = bounds.maxY - layer.shadowRadius
        shadowLayer.masksToBounds = false
        shadowLayer.shadowRadius = 6
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = .zero
        shadowLayer.shadowPath = UIBezierPath(rect: CGRect(x: .zero,
                                                           y: pointY,
                                                           width: bounds.width,
                                                           height: layer.shadowRadius)).cgPath
        
    }
    
    func setShadowIsHidden(isHidden: Bool) {
        shadowLayer.isHidden = isHidden
        collectionView.backgroundColor = isHidden ? Colors.mainBackGroundColor : .white
    }
}
extension CategoryHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.identifire, for: indexPath) as? SelectCategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: ModelSelectCatgoryCell(nameCategory: categories[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectCategory = indexPath.row == 0 ? indexPath.row : indexPath.row + 1
        delegate?.selectCategory(index: selectCategory)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
extension CategoryHeader: ScrollControlDelegate {
    func selectCategory(index category: Int) {
        self.collectionView.selectItem(at: IndexPath(row: category, section: .zero), animated: true, scrollPosition: .centeredHorizontally)
    }
}

