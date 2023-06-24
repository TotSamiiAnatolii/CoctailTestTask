//
//  ModuleBuilder.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    static func createMenu() -> UIViewController
    static func createContacts() -> UIViewController
    static func createProfile() -> UIViewController
    static func createShoppingCart() -> UIViewController
    static func createDetailDrink(id: String) -> UIViewController
}

final class ModuleBuilder: AssemblyBuilderProtocol {
    
    static func createDetailDrink(id: String) -> UIViewController {
        let networkService = NetworkManager()
        let presenter = DetailDrinkPresenter(netwokService: networkService)
        let view = DetailDrinkController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    static func createMenu() -> UIViewController {
        let networkService = NetworkManager()
        let presenter = MenuPresenter(networkService: networkService)
        let view = CoctailListController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    static func createContacts() -> UIViewController {
        let view = ContactsViewController()
        let presenter = ContactsPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createProfile() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createShoppingCart() -> UIViewController {
        let view = ShoppingCartViewController()
        let presenter = ShoppingCartPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
