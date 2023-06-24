//
//  CollectionMainLayout.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class CollectionMainLyout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }

        let sectionsToAdd = NSMutableIndexSet()
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for layoutAttributesSet in layoutAttributes {
            if layoutAttributesSet.representedElementCategory == .cell {
           
                newLayoutAttributes.append(layoutAttributesSet)

                sectionsToAdd.add(layoutAttributesSet.indexPath.section)

            } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
                sectionsToAdd.add(layoutAttributesSet.indexPath.section)
            }
        }

        for section in sectionsToAdd {
            let indexPath = IndexPath(item: 0, section: section)

            if let sectionAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
                newLayoutAttributes.append(sectionAttributes)
            }
        }
        return newLayoutAttributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
   
        if indexPath.section == 0 {
            guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else {
                return nil
            }
            return layoutAttributes
        }

        guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: IndexPath(item: 0, section: 1)) else {
            return nil
        }

            guard let boundaries = boundaries(forSection: indexPath.section) else { return layoutAttributes }

            guard let collectionView = collectionView else {
                return layoutAttributes }

            let contentOffsetY = collectionView.contentOffset.y
        
            var frameForSupplementaryView = layoutAttributes.frame

            let minimum = boundaries.minimum - frameForSupplementaryView.height
        
            if contentOffsetY < minimum {
                frameForSupplementaryView.origin.y = minimum

            } else {
                frameForSupplementaryView.origin.y = contentOffsetY
            }

            layoutAttributes.zIndex = 1100

            layoutAttributes.frame = frameForSupplementaryView

            return layoutAttributes
    }
    
    func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))

        guard let collectionView = collectionView else { return result }

        let numberOfItems = collectionView.numberOfItems(inSection: section)

        guard numberOfItems > 0 else { return result }

        if let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
           let lastItem = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: section)) {
            result.minimum = firstItem.frame.minY
            result.maximum = lastItem.frame.maxY

            result.minimum -= headerReferenceSize.height
            result.maximum -= headerReferenceSize.height

            result.minimum -= sectionInset.top
            result.maximum += (sectionInset.top + sectionInset.bottom)
        }

        return result
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
