//
//  CoctailListPresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol CoctailListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol)
    
    func getMenuList(categories: [ModelCategory])
    
    func setContentOffset(_ position: CGFloat, indexPath: IndexPath)
    
    func setHeader(current state: StateHeader, header: CategoryHeader)
    
    func updateStateDragging(state: StateScroll)
    
    func setColorNavBar(current state: StateHeader)
    
    func visibleCurrentSection(xOffset: CGFloat, yOffset: CGFloat, indent: CGFloat) -> Int?
    
    func visibleSupplementaryViews() -> [UICollectionReusableView]
    
    func setIndicatorDownload(state: StateDowload)
    
    var categories: [ModelCategory] { get set }
    
    var listMenu: [String: [ModelCoctailCell]] { get set }
    
    var topBannerList: [ModelTopBanner] { get set }
}

final class MenuPresenter: CoctailListPresenterProtocol {
    
    var view: CoctailListViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getMenuList(categories: categories)
    }
    
    var categories: [ModelCategory] = [ModelCategory(name: Category.coffeeTea.name, isSelected: true),
                                       ModelCategory(name: Category.shot.name, isSelected: false),
                                       ModelCategory(name: Category.beer.name, isSelected: false),
                                       ModelCategory(name: Category.shake.name, isSelected: false)]
    
    var listMenu: [String: [ModelCoctailCell]] = [:]
    
    var topBannerList: [ModelTopBanner] = []
    
    func getMenuList(categories: [ModelCategory]) {
        networkService.getMenuList(categories: categories) {[weak self] listMenu in
            self?.listMenu = listMenu

            DispatchQueue.main.async {
                self?.view?.succes()
            }
        }
    }
    
    func setContentOffset(_ position: CGFloat, indexPath: IndexPath) {
        if let cellAttributes = view?.menuView.collectionView?.layoutAttributesForItem(at: indexPath), indexPath.section > 0 {
            let scrollingPosition = CGPoint(x: .zero, y: cellAttributes.frame.origin.y - position)
            view?.menuView.collectionView?.setContentOffset(scrollingPosition, animated: true)
        } else {
            let scrollingPosition = CGPoint(x: 0, y: 0)
            view?.menuView.collectionView?.setContentOffset(scrollingPosition, animated: true)
        }
    }
    
    func setHeader(current state: StateHeader, header: CategoryHeader) {
        switch state {
        case .floats:
            header.setShadowIsHidden(isHidden: true)
            view?.menuView.navBarView.backgroundColor = Colors.mainBackGroundColor
        case .stiky:
            header.setShadowIsHidden(isHidden: false)
            view?.menuView.navBarView.backgroundColor = Colors.white
        }
    }
    
    func visibleCurrentSection(xOffset: CGFloat = 0, yOffset: CGFloat, indent: CGFloat) -> Int? {
        return view?.menuView.collectionView.indexPathForItem(at: CGPoint(x: xOffset, y: yOffset + indent))?.section
    }
    
    func visibleSupplementaryViews() -> [UICollectionReusableView] {
        guard let view = view else { return [] }
        return view.menuView.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    func setIndicatorDownload(state: StateDowload) {
        switch state {
        case .loading:
            view?.menuView.indicatorDownloads.isHidden = false
            view?.menuView.indicatorDownloads.startAnimating()
        case .downloadFinished:
            view?.menuView.indicatorDownloads.isHidden = true
            view?.menuView.indicatorDownloads.stopAnimating()
        }
    }
    
    func setColorNavBar(current state: StateHeader) {
        switch state {
        case .floats:
            view?.menuView.navBarView.backgroundColor = Colors.mainBackGroundColor
        case .stiky:
            view?.menuView.navBarView.backgroundColor = Colors.white
        }
    }
    
    func updateStateDragging(state: StateScroll) {
        view?.stateScroll = state
    }
}

