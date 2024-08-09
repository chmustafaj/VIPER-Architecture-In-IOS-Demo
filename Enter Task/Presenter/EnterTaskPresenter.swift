//
//  EnterTaskPresebter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

class EnterTaskPresenter: EnterTaskViewToPresenterProtocol {
  weak var view: EnterTaskPresenterToViewProtocol?
  
  var interactor: EnterTaskPresenterToInteractorProtocol?
  
  var router: EnterTaskPresenterToRouterProtocol?
  
  func startAddingTaskToList(listId: String, taskName: String) {
    interactor?.addTaskToList(listId: listId, taskName: taskName)
  }
}

extension EnterTaskPresenter: EnterTaskInteractorToPresenterProtocol {
  func taskAddedSuccess() {
    view?.showTaskAdded()
  }
  
  func taskAddedFailed() {
    view?.showError()
  }
  
  
}
