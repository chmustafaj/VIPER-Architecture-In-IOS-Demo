//
//  CloudPresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation

class CloudPresenter: CloudViewToPresenterProtocol {

  weak var view: CloudPresenterToViewProtocol?
  var interactor: CloudPresenterToInteractorProtocol?
  var router: CloudPresenterToRouterProtocol?
  
  func startFetchingToDos() {
    interactor?.fetchToDos() { result in  // result coming from the cloud interactor
      switch(result) {
      case .success(let entities):
        let viewModels = self.convertEntitiesToViewModels(entities: entities)
        self.view?.showToDos(tasksArray: viewModels)
      case .failure(let error):
        self.view?.showError(error: error)
      }
    }
  }
}
// MARK: - Helper functions
extension CloudPresenter {
  func convertEntitiesToViewModels(entities: [TodoEntity]) -> [ToDoViewModel] {
    return entities.map { ToDoViewModel(todo: $0.todo, isComplete: $0.completed) }
  }
}
