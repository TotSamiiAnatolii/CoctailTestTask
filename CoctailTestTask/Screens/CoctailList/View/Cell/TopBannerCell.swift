//
//  TopBannerCell.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class TopBannerCell: UICollectionViewCell {
    
    static let identifire = "TopBannerCell"
 
    private var topBannerList: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!
    ]
    
    var topBannerCollectionView: UICollectionView!
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        topBannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        topBannerCollectionView.collectionViewLayout = createCompositionalLayout()
        topBannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topBannerCollectionView.showsVerticalScrollIndicator = false
        topBannerCollectionView.backgroundColor = Colors.mainBackGroundColor
        topBannerCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifire)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout  {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) in
            return Layouts.shared.topBannerLayout()
        }
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupCollectionView()
        topBannerCollectionView.delegate = self
        topBannerCollectionView.dataSource = self
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(topBannerCollectionView)
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            topBannerCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            topBannerCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            topBannerCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            topBannerCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
extension TopBannerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topBannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifire, for: indexPath) as! BannerCell
        cell.configure(with: topBannerList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TopBannerCell")
    }
}
