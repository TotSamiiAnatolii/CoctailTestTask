//
//  ModuleBuilder.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMenu(router: RouterProtocol) -> UIViewController
    func createContacts(router: RouterProtocol) -> UIViewController
    func createProfile(router: RouterProtocol) -> UIViewController
    func createShoppingCart(router: RouterProtocol) -> UIViewController
    func createDetailDrink(id: String, router: RouterProtocol) -> UIViewController
}

final class ModuleBuilder: AssemblyBuilderProtocol {
    
    let coctailAPIManager: CoctailAPIManagerProtocol
    
    init(coctailAPIManager: CoctailAPIManagerProtocol) {
        self.coctailAPIManager = coctailAPIManager
    }
    
    func createDetailDrink(id: String, router: RouterProtocol) -> UIViewController {
        let presenter = DetailDrinkPresenter(id: id, coctailAPIManager: coctailAPIManager, router: router)
        let view = DetailDrinkController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createMenu(router: RouterProtocol) -> UIViewController {
        let presenter = MenuPresenter(coctailAPIManager: coctailAPIManager, router: router)
        let view = CoctailListController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createContacts(router: RouterProtocol) -> UIViewController {
        let view = ContactsViewController()
        let presenter = ContactsPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createProfile(router: RouterProtocol) -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func createShoppingCart(router: RouterProtocol) -> UIViewController {
        let view = ShoppingCartViewController()
        let presenter = ShoppingCartPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
