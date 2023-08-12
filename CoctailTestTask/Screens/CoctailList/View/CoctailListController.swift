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
    
    //MARK: - Main view
    var menuView: CoctailListView {
        guard let view = self.view as? CoctailListView else {
            return CoctailListView()
        }
        return view
    }
    
    private var presenter: MenuPresenter
    
    //MARK: - Delegate
    weak var delegate: ScrollControlDelegate?
    
    //MARK: - Constants
    private let countItemInTopBarSection = 1
    
    private let heightHeader: CGFloat = 70
    
    private let heightTopBanner: CGFloat = 140
    
    private let heightCoctailCell: CGFloat = 170
    
    //MARK: - Variables
    private var minYCategoryHeader: CGFloat = 0
    
    private var stateHeader: StateHeader = .floats
    
    private var lastCategory = 0
    
    internal var stateScroll: StateScroll  = .userInteracts
    
    private var totalNumberOfSections: Int {
        listMenu.count + 1
    }
    
    //MARK: -
    private var refreshControl = UIRefreshControl()
    
    //MARK: - Data source
    private var listMenu: [String: [ModelCoctailCell]] = [:]
    
    private var categories: [ModelCategory] = []
    
    //MARK: - Init
    init(presenter: MenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cicle VC
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
extension CoctailListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        let typeSection = TypeSection(rawValue: section) ?? .menuList
                
        switch typeSection {
        case .topBanner:
            return countItemInTopBarSection
        case .menuList:
            return listMenu[categories[typeSection.currentSection(section)].name]?.count ?? 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        totalNumberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let typeSection = TypeSection(rawValue: indexPath.section) ?? .menuList
        
        switch typeSection {
        case .topBanner:
            guard let topBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBannerCell.identifire, for: indexPath) as? TopBannerCell else {
                return UICollectionViewCell()
            }
            return topBannerCell
        case .menuList:
            guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoctailCell.identifire, for: indexPath) as? CoctailCell else {
                return UICollectionViewCell()
            }
            
            if let product = listMenu[categories[typeSection.currentSection(indexPath.section)].name]?[indexPath.row] {
                menuCell.configure(with: product)
            }
            return menuCell
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presenter.showCoctail(id: "")
        print(listMenu[categories[indexPath.section].name]?[indexPath.row].nameProduct)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? CoctailCell {
//            cell.animate()
//        }
        UIView.animate(withDuration: 0.1) {
               if let cell = collectionView.cellForItem(at: indexPath) as? CoctailCell {
                   cell.animate()
//                   cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
               }
           }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
              if let cell = collectionView.cellForItem(at: indexPath) as? CoctailCell {
                  cell.productImage.transform = .identity
                  cell.stackView.transform = .identity
                  cell.priceFromView.transform = .identity
              }
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
    }
    
    func setIndicatorDownload(state: StateDowload) {
        menuView.indicatorDownloads.controlActivityIndicator(state: state)
    }
    
    func failure(error: Error) {
        print(error)
    }

    func succes(models: [String: [ModelCoctailCell]]) {
        listMenu = models
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
extension CoctailListController: ScrollControlDelegate {
    
    func selectCategory(index category: Int) {
        stateScroll = .programScroll
        lastCategory = .zero
        let indexPatch = IndexPath(row: .zero, section: category)
        setContentOffset(heightHeader, indexPath: indexPatch)
    }
}

