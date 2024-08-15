//
//  CloudPresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import Alamofire

class CloudPresenter: CloudScenePresenterInput {

  weak var viewController: CloudScenePresenterOutput?
  
  func showTodos(todos: [TodoEntity]) {
    viewController?.showToDos(tasksArray: convertEntitiesToViewModels(entities: todos))
  }
  
  func showError(error: Alamofire.AFError) {
    viewController?.showError(error: error)
  }
}

// MARK: - Helper functions
extension CloudPresenter {
  func convertEntitiesToViewModels(entities: [TodoEntity]) -> [ToDoViewModel] {
    return entities.map { ToDoViewModel(todo: $0.todo, isComplete: $0.completed) }
  }
}
