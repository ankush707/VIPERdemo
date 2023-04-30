//
//  TableRouter.swift
//  VIPERdemo
//
//  Created by Ankush on 31/03/23.
//

import Foundation
import UIKit

//Object
//Protocol
// Refer To View, Interactor and Presenter

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var presenter: AnyPresenter? { get set }
    
    static func start() -> AnyRouter
}

class TableRouter: AnyRouter {
    var entry: EntryPoint?
    
    var view: AnyView?
    
    var interactor: AnyInteractor?
    
    var presenter: AnyPresenter?
    
    static func start() -> AnyRouter {
        let router = TableRouter()
        
        let view = TableVC()
        let interactor = TableInteractor()
        let presenter = TablePresenter()
        
        router.view = view
        router.interactor = interactor
        router.presenter = presenter
        
        view.tablePresenter = presenter
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
