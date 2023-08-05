//
//  TabBarController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTintColor()
        setIndentTabBarImage()
    }

    private func setIndentTabBarImage() {
        guard let items = tabBar.items else {
            return
        }
        for item in 0 ..< items.count {
            items[item].imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
        }
    }
    
    private func setTintColor() {
        UITabBar.appearance().tintColor = .red
    }
    
    func createViewController(rootViewController: UIViewController?, image: UIImage) -> UIViewController {
        guard let rootViewController = rootViewController else {
            return UIViewController()
        }
        let viewController = UINavigationController(rootViewController: rootViewController)
        let tabBarItem = UITabBarItem()
        tabBarItem.image = image
        rootViewController.tabBarItem = tabBarItem
        return rootViewController
    }
}
