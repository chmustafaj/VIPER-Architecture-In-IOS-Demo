//
//  Router.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalRouter:LocalPresenterToRouterProtocol {
  weak var viewController: UIViewController?
  
  func createEntryModule(listToAddTaskToId: String, update: @escaping (()->Void)) {
    let entryVC = EnterTaskRouter().createModule(listWeAreAddingToId: listToAddTaskToId)
    entryVC.update = update
    viewController?.navigationController?.pushViewController(entryVC, animated: true)
  }
  
  func createModule(selectedGroupId: String) -> TasksViewController {
    let view = TasksViewController()
    let presenter: LocalViewToPresenterProtocol = LocalPresenter(listId: selectedGroupId)
    let interactor: LocalPresenterToInteractorProtocol = LocalInteractor(dataManager: DataManager())
    let router:LocalPresenterToRouterProtocol = LocalRouter()
    view.presentor = presenter
    router.viewController = view
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    return view
  }
  
}
