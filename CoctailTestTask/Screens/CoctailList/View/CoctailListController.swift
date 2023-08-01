//
//  ViewController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol CoctailListViewProtocol: AnyObject {
    
    var menuView: CoctailListView { get }
    
    var stateScroll: StateScroll { get set }
    
    func succes(models: [String: [ModelCoctailCell]])
    
    func categories(models: [ModelCategory])
    
    func failure(error: Error)
    
    func visibleCurrentSection(xOffset: CGFloat, yOffset: CGFloat, indent: CGFloat) -> Int?
    
    func visibleSupplementaryViews() -> [UICollectionReusableView]
    
    func setContentOffset(_ position: CGFloat, indexPath: IndexPath)
    
    func setHeader(current state: StateHeader, header: CategoryHeader)
    
    func setIndicatorDownload(state: StateDowload)
    
    func setColorNavBar(current state: StateHeader)
}

final class CoctailListController: UIViewController {
    
    var menuView: CoctailListView {
        guard let view = self.view as? CoctailListView else {
            return CoctailListView()
        }
        return view
    }
    
    private var presenter: MenuPresenter
    
    private var minYCategoryHeader: CGFloat = 0
    
    private let countItemInTopBarSection = 1
    
    private let heightHeader: CGFloat = 70
    
    private var stateHeader: StateHeader = .floats
    
    private var lastCategory = 0
    
    internal var stateScroll: StateScroll  = .userInteracts
    
    weak var delegate: ScrollControlDelegate?
    
    private var refreshControl = UIRefreshControl()
    
    private let heightTopBanner: CGFloat = 140
    
    private let heightCoctailCell: CGFloat = 170
    
    private var listMenu: [String: [ModelCoctailCell]] = [:]
    
    private var categories: [ModelCategory] = []
    
    init(presenter: MenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = CoctailListView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupNavigationBar()
        configureView()
    }
 
    private func setupCollectionView() {
        menuView.collectionView.delegate = self
        menuView.collectionView.dataSource = self
    }
    
    private func configureView() {
        menuView.configure(with: ModelMenuView())
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
extension CoctailListController: ScrollControlDelegate {
    
    func selectCategory(index category: Int) {
        stateScroll = .programScroll
        lastCategory = .zero
        let indexPatch = IndexPath(row: .zero, section: category)
        setContentOffset(heightHeader, indexPath: indexPatch)
    }
}
extension CoctailListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let sectionType = TypeSection.init(rawValue: section) else {
//            return 0
//        }

        if section == 0 {
            return countItemInTopBarSection
        } else {
            print(listMenu[categories[section - 1].name]?.count)
            return listMenu[categories[section - 1].name]?.count ?? 0
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        print(listMenu["Shake"]?.count)
        return listMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            guard let topBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBannerCell.identifire, for: indexPath) as? TopBannerCell else {
                return UICollectionViewCell()
            }
            return topBannerCell
        }
            guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoctailCell.identifire, for: indexPath) as? CoctailCell else {
                return UICollectionViewCell()
            }
        print(categories[indexPath.section - 1].name)
        print(indexPath.row)
//        if categories[indexPath.section - 1].name == "Shake" {
//
//        }
        
        if let product = listMenu[categories[indexPath.section - 1].name]?[indexPath.row] {
            menuCell.configure(with: product)
        }
               
//            }
            return menuCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let typeSection = TypeSection.init(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        switch typeSection {
            
        case .menuList:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeader.identifire, for: indexPath) as? CategoryHeader else {
                return UICollectionReusableView()
            }
            minYCategoryHeader = header.frame.origin.y
            header.delegate = self
            header.dataSource = self
            self.delegate = header
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let typeSection = CategoryType.init(rawValue: indexPath.section) ?? .menu
        
        switch typeSection {
        case .topBanner:
            return CGSize(width: collectionView.frame.width, height: heightTopBanner)
        case .menu:
            return CGSize(width: collectionView.frame.width, height: heightCoctailCell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1 {
            return CGSize(width: collectionView.frame.width, height: heightHeader)
        } else {
            return CGSize(width: collectionView.frame.width, height: .zero)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset
        let extraIndent: CGFloat = 3
        var heightHeader: CGFloat = 0
        let visibleHeadersInSection = visibleSupplementaryViews()
        
        visibleHeadersInSection.forEach { header in
            guard let categoryHeader = header as? CategoryHeader else {
                return
            }
            heightHeader = header.frame.height
            
            stateHeader = offSet.y > minYCategoryHeader - extraIndent ? .stiky : .floats
            setHeader(current: stateHeader, header: categoryHeader)
            setColorNavBar(current: stateHeader)
        }
        
        guard let currentCategory = visibleCurrentSection(yOffset: offSet.y, indent: heightHeader) else {
            return
        }
        
        if stateScroll == .userInteracts && lastCategory != currentCategory {
            let selectCategory = currentCategory == 0 ? currentCategory : currentCategory - 1
            delegate?.selectCategory(index: selectCategory)
            lastCategory = currentCategory
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        presenter.updateStateDragging(state: .userInteracts)
    }
}
extension CoctailListController: CoctailListViewProtocol {
    func categories(models: [ModelCategory]) {
        categories = models
        print(categories.count)
    }
    
   
    func setIndicatorDownload(state: StateDowload) {
        switch state {
        case .loading:
            menuView.indicatorDownloads.isHidden = false
            menuView.indicatorDownloads.startAnimating()
        case .downloadFinished:
            menuView.indicatorDownloads.isHidden = true
            menuView.indicatorDownloads.stopAnimating()
        }
    }
    
    func failure(error: Error) {
        print(error)
    }

    func succes(models: [String: [ModelCoctailCell]]) {
        listMenu = models
        print(models.count)
        setupCollectionView()
        menuView.collectionView.reloadData()
    }
    
    func setContentOffset(_ position: CGFloat, indexPath: IndexPath) {
        if let cellAttributes = menuView.collectionView?.layoutAttributesForItem(at: indexPath), indexPath.section > 0 {
            let scrollingPosition = CGPoint(x: .zero, y: cellAttributes.frame.origin.y - position)
            menuView.collectionView?.setContentOffset(scrollingPosition, animated: true)
        } else {
            let scrollingPosition = CGPoint(x: 0, y: 0)
            menuView.collectionView?.setContentOffset(scrollingPosition, animated: true)
        }
    }
    
    func setHeader(current state: StateHeader, header: CategoryHeader) {
        switch state {
        case .floats:
            header.setShadowIsHidden(isHidden: true)
            menuView.navBarView.backgroundColor = Colors.mainBackGroundColor
        case .stiky:
            header.setShadowIsHidden(isHidden: false)
            menuView.navBarView.backgroundColor = Colors.white
        }
    }
    
    func visibleCurrentSection(xOffset: CGFloat = 0, yOffset: CGFloat, indent: CGFloat) -> Int? {
        return menuView.collectionView.indexPathForItem(at: CGPoint(x: xOffset, y: yOffset + indent))?.section
    }
    
    func visibleSupplementaryViews() -> [UICollectionReusableView] {
        return menuView.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    func setColorNavBar(current state: StateHeader) {
        switch state {
        case .floats:
            menuView.navBarView.backgroundColor = Colors.mainBackGroundColor
        case .stiky:
            menuView.navBarView.backgroundColor = Colors.white
        }
    }
}
extension CoctailListController: DataSourceHeader {
    func getCategory(_ indexPath: IndexPath) -> ModelCategory {
        categories[indexPath.row]
    }
    
    func numberOfItems(_ header: CategoryHeader) -> Int {
        categories.count
    }
}

