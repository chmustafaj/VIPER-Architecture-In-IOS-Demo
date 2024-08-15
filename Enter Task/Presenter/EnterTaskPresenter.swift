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
  let listId: String
  
  init(listId: String) {
    self.listId = listId
  }
  func startAddingTaskToList(taskName: String) {
    interactor?.addTaskToList(listWeAreAddingTaskTo:listId, taskName: taskName) { [self] isSuccesfull in
      if(isSuccesfull){
        view?.showTaskAdded()
      }else{
        view?.showError()
      }
    }
  }
}
