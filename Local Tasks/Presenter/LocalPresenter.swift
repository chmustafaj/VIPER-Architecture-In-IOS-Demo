//
//  LocalPresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalPresenter:LocalViewToPresenterProtocol {
  
  weak var view: LocalPresenterToViewProtocol?
  
  var interactor: LocalPresenterToInteractorProtocol?
  
  var router: LocalPresenterToRouterProtocol?
  
  func startFetchingToDos(selectedListId: String) {
    interactor?.fetchTasks(listId: selectedListId)
  }
  func deleteItemRequested(taskToDeleteId: String) {
    interactor?.deleteTask(taskToDeleteId)
  }
  
  func toggleTaskIsCompleteRequest(taskToToggleId: String, isComplete: Bool){
    interactor?.toggleTaskIsComplete(taskToToggleId, isComplete)
  }
}

extension LocalPresenter: LocalInteractorToPresenterProtocol{
  
  func tasksFetchedSuccess(tasksModelArray: [TaskViewModel]) {
    view?.showTasks(tasksArray: tasksModelArray)
  }
  
  func tasksFetchFailed() {
    view?.showError()
  }
  
}
