//
//  CloudRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

class CloudRouter: CloudPresenterToRouterProtocol {
  
  static func createModule(selectedGroup: Group) -> CloudViewController {
    let view = CloudViewController()
    
    let presenter: CloudViewToPresenterProtocol & CloudInteractorToPresenterProtocol = CloudPresenter()
    let interactor: CloudPresenterToInteractorProtocol = CloudInteractor()
    let router:CloudPresenterToRouterProtocol = CloudRouter()
    
    view.presentor = presenter
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    
    return view
  }
}
