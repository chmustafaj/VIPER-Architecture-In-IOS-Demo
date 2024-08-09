//
//  HomeRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation

class HomeRouter: HomePresenterToRouterProtocol {
  
  func createModule() -> HomeViewController {
    
    let view = HomeViewController()
    
    let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
    let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
    let router:HomePresenterToRouterProtocol = HomeRouter()
    
    view.presenter = presenter
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    
    return view
    
  }
}
