//
//  BaseRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
class BaseRouter: BasePresenterToRouterProtocol {
  
  func createHomeViewController() -> HomeViewController {
    let homeViewController = HomeViewController()

    let homePresenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
    let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
    let router: HomePresenterToRouterProtocol = HomeRouter()
    
    homeViewController.presenter = homePresenter
    homePresenter.view = homeViewController
    homePresenter.router = router
    homePresenter.interactor = interactor
    interactor.presenter = homePresenter
    return homeViewController
  }
  
  func createCloudViewController() -> CloudViewController {
    let cloudViewController = CloudViewController()

    let cloudPresenter: CloudViewToPresenterProtocol & CloudInteractorToPresenterProtocol = CloudPresenter()
    let interactor: CloudPresenterToInteractorProtocol = CloudInteractor()
    let router: CloudPresenterToRouterProtocol = CloudRouter()
    
    cloudViewController.presentor = cloudPresenter
    cloudPresenter.view = cloudViewController
    cloudPresenter.router = router
    cloudPresenter.interactor = interactor
    interactor.presenter = cloudPresenter
    return cloudViewController
  }
  
  func createModule() -> BaseViewController {
    
    let view = BaseViewController()
    
    let presenter: BaseViewToPresenterProtocol & BaseInteractorToPresenterProtocol = BasePresenter()
    let interactor: BasePresenterToInteractorProtocol = BaseInteractor()
    let router: BasePresenterToRouterProtocol = BaseRouter()
    
    view.presenter = presenter
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    
    return view
    
  }
}

