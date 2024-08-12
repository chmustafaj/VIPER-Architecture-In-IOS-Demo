//
//  EnterTaskRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

class EnterTaskRouter: EnterTaskPresenterToRouterProtocol {
  weak var tasksViewController: EnterTaskPresenterToViewProtocol?
  
  func createModule(listWeAreAddingToId: String) -> EntryViewController {
    let view = EntryViewController(listToAddTaskToId: listWeAreAddingToId)
    let presenter: EnterTaskViewToPresenterProtocol & EnterTaskInteractorToPresenterProtocol = EnterTaskPresenter()
    let interactor: EnterTaskPresenterToInteractorProtocol = EnterTaskInteractor()
    let router:EnterTaskPresenterToRouterProtocol = EnterTaskRouter()
    view.presenter = presenter
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    return view
    
  }
}
