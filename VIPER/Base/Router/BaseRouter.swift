//
//  BaseRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
import UIKit

class BaseRouter: BasePresenterToRouterProtocol {
  weak var viewController: UIViewController?

  func createHomeViewController() -> HomeViewController {
    let sceneFactory = DefaultSceneFactory()
    return DefualtHomeSceneConfigurator(sceneFactory: sceneFactory).configured(HomeViewController())
  }
  
  func createCloudViewController() -> CloudViewController {
    return DefultCloudSceneConfigurator().configured(CloudViewController()) 
  }
  
  func createModule() -> BaseViewController {
    let view = BaseViewController()
    let presenter: BaseViewToPresenterProtocol & BaseInteractorToPresenterProtocol = BasePresenter()
    let interactor: BasePresenterToInteractorProtocol = BaseInteractor(dataManager: DataManager())
    let router: BasePresenterToRouterProtocol = BaseRouter()
    view.presenter = presenter
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    view.router = router
    self.viewController = view
    return view
  }
}

