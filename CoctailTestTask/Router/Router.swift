//
//  Router.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol RouteProtocol {
    func initialViewController()
    func showDetail(id: String)
    func popToRoot()
    
}

protocol MenuRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}
