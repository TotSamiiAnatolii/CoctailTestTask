//
//  Router.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol MenuRouterProtocol {
    var tabBarController: TabBarController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: MenuRouterProtocol {
    func initialViewController()
    func showDetail(id: String)
    func popToRoot()
    
}

final class Router: RouterProtocol {
    
    var tabBarController: TabBarController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(tabBarController: TabBarController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.tabBarController = tabBarController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        guard let tabBarController = tabBarController else {
            return
        }
        let contacts = tabBarController.createViewController(
            rootViewController: (assemblyBuilder?.createContacts(router: self)),
            image: Images.contacts)
        let menu = tabBarController.createViewController(
            rootViewController: (assemblyBuilder?.createMenu(router: self)),
            image: Images.menu)
        let profile = tabBarController.createViewController(
            rootViewController: (assemblyBuilder?.createProfile(router: self)),
            image: Images.profile)
        let shoppingCart = tabBarController.createViewController(
            rootViewController: (assemblyBuilder?.createShoppingCart(router: self)),
            image: Images.shoppingCart)
        tabBarController.viewControllers = [menu, contacts, profile, shoppingCart]
    }
    
    func showDetail(id: String) {
        let detailVC = assemblyBuilder?.createDetailDrink(id: id, router: self)
    }
    
    func popToRoot() {
        
    }}
