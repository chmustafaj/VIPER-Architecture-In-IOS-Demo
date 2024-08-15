//
//  HomeRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
  weak var viewController: UIViewController?
  
  func createModule() -> HomeViewController {
    let view = HomeViewController()
    let presenter: HomeViewToPresenterProtocol = HomePresenter()
    let interactor: HomePresenterToInteractorProtocol = HomeInteractor(dataManager: DataManager()) //DI
    view.presenter = presenter
    presenter.view = view
    presenter.router = self
    presenter.interactor = interactor
    self.viewController = view
    return view
  }
  
  func startLoadingTasksScreen(listId: String) {
    let taskVC = LocalRouter().createModule(selectedGroupId: listId)
    viewController?.navigationController?.pushViewController(taskVC, animated: true)
  }
}
