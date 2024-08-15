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
    let view = EntryViewController() 
    let presenter: EnterTaskViewToPresenterProtocol = EnterTaskPresenter(listId: listWeAreAddingToId)
    let interactor: EnterTaskPresenterToInteractorProtocol = EnterTaskInteractor(dataManager: DataManager())
    let router:EnterTaskPresenterToRouterProtocol = EnterTaskRouter()
    view.presenter = presenter
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    return view
    
  }
}
