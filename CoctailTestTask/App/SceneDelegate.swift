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
        let navigationController = UINavigationController()
        let networkService = NetworkManager()
        let coctailAPIManager = CoctailAPIManager(networkManager: networkService)
        let assemblyBuilder = ModuleBuilder(coctailAPIManager: coctailAPIManager)
        let router = Router(tabBarController: tabBarController, assemblyBuilder: assemblyBuilder, navigationController: navigationController)
        router.initialViewControllers()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

