//
//  CloudRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
import UIKit

class CloudRouter: CloudPresenterToRouterProtocol {
  weak var viewController: UIViewController?
  
   func createModule() -> CloudViewController {
    let view = CloudViewController()
    let presenter: CloudViewToPresenterProtocol = CloudPresenter()
    let interactor: CloudPresenterToInteractorProtocol = CloudInteractor(networkManager: NetworkManager())
    view.presentor = presenter
    presenter.view = view
    presenter.router = self
    presenter.interactor = interactor
    self.viewController = view
    return view
  }
}
