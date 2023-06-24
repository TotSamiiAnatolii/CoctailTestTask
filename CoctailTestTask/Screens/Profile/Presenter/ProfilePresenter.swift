//
//  ProfilePresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    let view: ProfileViewProtocol
    
    init(view: ProfileViewProtocol) {
        self.view = view
    }

}
