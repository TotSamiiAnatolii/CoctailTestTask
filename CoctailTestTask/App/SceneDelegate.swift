//
//  SceneDelegate.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let tabBarController = TabBarController()
        let navTabBar = UINavigationController(rootViewController: tabBarController)
        window?.rootViewController = navTabBar
        window?.makeKeyAndVisible()
    }
}

