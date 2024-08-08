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
  
  func startFetchingToDos(selectedList: Group) {
    interactor?.fetchTasks(list: selectedList)
  }
  func deleteItemRequested(itemToDelete: Task) {
    interactor?.deleteTask(itemToDelete)
  }
  
  func toggleTaskIsCompleteRequest(taskToToggle: Task, isComplete: Bool){
    interactor?.toggleTaskIsComplete(taskToToggle, isComplete)
  }
}

extension LocalPresenter: LocalInteractorToPresenterProtocol{
  
  func tasksFetchedSuccess(tasksModelArray: Array<Task>) {
    view?.showTasks(tasksArray: tasksModelArray)
  }
  
  func tasksFetchFailed() {
    view?.showError()
  }
  
}
