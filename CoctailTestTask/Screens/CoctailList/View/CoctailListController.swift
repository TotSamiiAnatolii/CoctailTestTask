//
//  ViewController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol CoctailListViewProtocol {
    var menuView: CoctailListView { get }
    var stateScroll: StateScroll { get set}
    func succes()
}

protocol ScrollControlDelegate: AnyObject {
    func selectCategory(index category: Int)
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
    
    private let heightHeader: CGFloat = 70
    
    private var stateHeader: StateHeader = .floats
    
    private var lastCategory = 0
    
    internal var stateScroll: StateScroll  = .userInteracts
    
    weak var delegate: ScrollControlDelegate?
    
    private var refreshControl = UIRefreshControl()
    
    private let heightTopBanner: CGFloat = 140
    
    private let heightCoctailCell: CGFloat = 170
    
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
        setupNavigationBar()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.setIndicatorDownload(state: .loading)
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
        print("до нажатия \(stateScroll)")
        stateScroll = .programScroll
        print("после нажатия \(stateScroll)")
        lastCategory = .zero
        let indexPatch = IndexPath(row: .zero, section: category)
        presenter.setContentOffset(heightHeader, indexPath: indexPatch)
    }
}
extension CoctailListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = TypeSection.init(rawValue: section) else {
            return 0
        }
        
        switch sectionType {
        case .topBanner:
            return 1
        case .coffeeTea:
            return presenter.listMenu[sectionType.name]?.count ?? 0
        case .shot:
            return presenter.listMenu[sectionType.name]?.count ?? 0
        case .beer:
            return presenter.listMenu[sectionType.name]?.count ?? 0
        case .shake:
            return presenter.listMenu[sectionType.name]?.count ?? 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TypeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionType = TypeSection.init(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch sectionType {
            
        case .topBanner:
            guard let topBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBannerCell.identifire, for: indexPath) as? TopBannerCell else {
                return UICollectionViewCell()
            }
            return topBannerCell
            
        case .coffeeTea:
            guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoctailCell.identifire, for: indexPath) as? CoctailCell else {
                return UICollectionViewCell()
            }
            
            guard let category = TypeSection.init(rawValue: indexPath.section) else {
                return UICollectionViewCell()
            }
            
            if presenter.listMenu.count > 0 {
                menuCell.configure(with: (presenter.listMenu[category.name]?[indexPath.row])!)
            }
            return menuCell
            
        default:
            guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: CoctailCell.identifire, for: indexPath) as? CoctailCell else {
                return UICollectionViewCell()
            }
            guard let category = TypeSection.init(rawValue: indexPath.section) else {
                return UICollectionViewCell()
            }
            if presenter.listMenu.count > 0 {
                menuCell.configure(with: (presenter.listMenu[category.name]?[indexPath.row])!)
            }
            return menuCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let typeSection = TypeSection.init(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        switch typeSection {
            
        case .coffeeTea:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeader.identifire, for: indexPath) as? CategoryHeader else {
                return UICollectionReusableView()
            }
            minYCategoryHeader = header.frame.origin.y
            header.delegate = self
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
        let visibleHeadersInSection = presenter.visibleSupplementaryViews()
        
        visibleHeadersInSection.forEach { header in
            guard let categoryHeader = header as? CategoryHeader else {
                return
            }
            heightHeader = header.frame.height
            
            stateHeader = offSet.y > minYCategoryHeader - extraIndent ? .stiky : .floats
            presenter.setHeader(current: stateHeader, header: categoryHeader)
            presenter.setColorNavBar(current: stateHeader)
        }
        
        guard let currentCategory = presenter.visibleCurrentSection(yOffset: offSet.y, indent: heightHeader) else {
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
    
    func succes() {
        setupCollectionView()
        menuView.collectionView.reloadData()
        presenter.setIndicatorDownload(state: .downloadFinished)
    }
}


