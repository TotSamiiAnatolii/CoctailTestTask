//
//  ShoppingCartViewController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol ShoppingCartViewProtocol {
    
}

final class ShoppingCartViewController: UIViewController {
    
    var presenter: ShoppingCartPresenter?
    
    fileprivate var shoppingCartView: ShoppingCartView {
        guard let view = self.view as? ShoppingCartView else {
            return ShoppingCartView()
        }
        return view
    }
    
    override func loadView() {
        super.loadView()
        self.view = ShoppingCartView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ShoppingCartViewController: ShoppingCartViewProtocol {
    
}
