//
//  Layouts.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

class Layouts {
    
    static let shared = Layouts()
    
    func topBannerLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(300), heightDimension: .absolute(120)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    func setCategoryLayoutPanel() -> NSCollectionLayoutSection  {
        let widthDimension = NSCollectionLayoutDimension.estimated(80)
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: widthDimension, heightDimension: .absolute(32)))
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: NSCollectionLayoutSpacing.fixed(8), top: nil, trailing:  nil, bottom: nil)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: widthDimension, heightDimension: .absolute(32)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 8, bottom: 14, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
