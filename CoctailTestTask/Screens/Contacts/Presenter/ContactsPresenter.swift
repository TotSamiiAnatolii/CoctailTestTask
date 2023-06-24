//
//  ContactsPresenter.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import Foundation

protocol ContactsPresenterProtocol: AnyObject {
    init(view: ContactsViewProtocol)
    
}

final class ContactsPresenter: ContactsPresenterProtocol {
    
    let view: ContactsViewProtocol
    
    init(view: ContactsViewProtocol) {
        self.view = view
    }
}
