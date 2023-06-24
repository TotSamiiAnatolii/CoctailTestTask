//
//  ShoppingCartPresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol ShoppingCartPresenterProtocol: AnyObject {
    
    init (view: ShoppingCartViewProtocol)
}

final class ShoppingCartPresenter: ShoppingCartPresenterProtocol {
    
    let view: ShoppingCartViewProtocol
    
    init(view: ShoppingCartViewProtocol) {
        self.view = view
    }
}
