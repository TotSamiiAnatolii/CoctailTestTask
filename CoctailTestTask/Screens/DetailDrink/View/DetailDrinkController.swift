//
//  DetailDrinkController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol DetailDrinkViewProtocol: AnyObject {
    
    func configureView(drink: Cocktail)
}

final class DetailDrinkController: UIViewController {

     var detailDrink: DetailDrinkView {
        guard let view = self.view as? DetailDrinkView else {
            return DetailDrinkView()
        }
        return view
    }
    
    let presenter: DetailDrinkPresenterProtocol
    
    override func loadView() {
        super.loadView()
        self.view = DetailDrinkView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(presenter: DetailDrinkPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        detailDrink.configure(with: ModelDetailDrinkView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DetailDrinkController: DetailDrinkViewProtocol {
    
    func configureView(drink: Cocktail) {
      
        let modelView = ModelDetailDrinkView()
        detailDrink.configure(with: modelView)
    }
}
