//
//  LocalPresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalPresenter: LocalViewToPresenterProtocol {

  weak var view: LocalPresenterToViewProtocol?
  var interactor: LocalPresenterToInteractorProtocol?
  var router: LocalPresenterToRouterProtocol?
  let listId: String
  
  init(listId: String){
    self.listId = listId
  }
  
  func startFetchingToDos() { // pass directly
    interactor?.fetchTasks(listId: listId) { [self] entities in
      if(entities.isEmpty == false) {
        let taskViewModels = convertEntitiesToViewModels(taskEntities: entities)
        view?.showTasks(tasksArray: taskViewModels)
      }else {
        view?.showError()
      }
    }
  }
  
  func deleteItemRequested(taskToDeleteId: String) {
    interactor?.deleteTask(taskToDeleteId)
  }
  
  func toggleTaskIsCompleteRequest(taskToToggleId: String, isComplete: Bool){
    interactor?.toggleTaskIsComplete(taskToToggleId, isComplete)
  }
  
  func startLoadingEnterTaskScreen(update: @escaping (()->Void)) {
    router?.createEntryModule(listToAddTaskToId: listId, update: update)
  }
}

// MARK: - Helper Functions
extension LocalPresenter {
  func convertEntitiesToViewModels(taskEntities: [Task]) -> [TaskViewModel] {
    var taskViewModels = [TaskViewModel]()
    for task in taskEntities {
      let taskVM = TaskViewModel(name: task.name!, isComplete: task.isComplete)
      taskViewModels.append(taskVM)
    }
    return taskViewModels
  }
}

