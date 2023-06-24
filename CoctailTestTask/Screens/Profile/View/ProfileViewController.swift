//
//  ProfileViewController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol ProfileViewProtocol {
    
}

final class ProfileViewController: UIViewController {

    weak var presenter: ProfilePresenterProtocol?
    
    fileprivate var profileView: ProfileView {
        guard let view = self.view as? ProfileView else {
            return ProfileView()
        }
        return view
    }
    
    override func loadView() {
        super.loadView()
        self.view = ProfileView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ProfileViewController: ProfileViewProtocol {
    
}
