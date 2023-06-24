//
//  TabBarController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
        setIndentTabBarImage()
    }
    
    private func configureTabBarController() {
        self.navigationController?.navigationBar.isHidden = true
        viewControllers = controllersAssembly()
    }
    
    private func setIndentTabBarImage() {
        guard let items = tabBar.items else {
            return
        }
        for item in 0 ..< items.count {
            items[item].imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        }
        UITabBar.appearance().tintColor = .red
    }
    
    private func createViewController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        let viewController = UINavigationController(rootViewController: rootViewController)
        let tabBarItem = UITabBarItem()
        tabBarItem.image = image
        viewController.tabBarItem = tabBarItem
        viewController.tabBarItem.title = title
        return viewController
    }
    
    private func controllersAssembly() -> [UIViewController] {
        return [
            createViewController(rootViewController: ModuleBuilder.createMenu(), image: Images.menu),
            createViewController(rootViewController: ModuleBuilder.createContacts(), image: Images.contacts),
            createViewController(rootViewController: ModuleBuilder.createProfile(), image: Images.profile),
            createViewController(rootViewController: ModuleBuilder.createShoppingCart(), image: Images.shoppingCart)
        ]
    }
}
