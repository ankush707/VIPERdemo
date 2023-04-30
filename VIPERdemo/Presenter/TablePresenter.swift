//
//  TablePresenter.swift
//  VIPERdemo
//
//  Created by Ankush on 31/03/23.
//

import Foundation

//Object
//Protocol
//Ref to  View, Interactor, Router

protocol AnyPresenter {
    
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    
    func showUsers(with users: Result<TableEntity, Error>)
    
}

class TablePresenter: AnyPresenter {
    
    
    var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsersApiCall()
        }
    }
    
    var router: AnyRouter?
    

    func showUsers(with users: Result<TableEntity, Error>) {
        
        switch users {
        case .success(let userData):
            self.view?.presentUsers(with: userData)
        case .failure(let error):
            self.view?.presentAlert(with: error.localizedDescription)
        }
        
    }
    
}
