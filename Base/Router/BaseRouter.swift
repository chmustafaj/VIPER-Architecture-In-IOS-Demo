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
    return HomeRouter().createModule()
  }
  
  func createCloudViewController() -> CloudViewController {
    return CloudRouter().createModule()
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

