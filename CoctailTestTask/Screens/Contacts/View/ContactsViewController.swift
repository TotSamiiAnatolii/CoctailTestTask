//
//  ContactsViewController.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

protocol ContactsViewProtocol: AnyObject {
    
}

final class ContactsViewController: UIViewController {
    
    fileprivate var contactsView: ContatsView {
       guard let view = self.view as? ContatsView else {
            return ContatsView()
        }
        return view
    }
    
    var presenter: ContactsPresenterProtocol?

    override func loadView() {
        super.loadView()
        self.view = ContatsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ContactsViewController: ContactsViewProtocol {
    
}
