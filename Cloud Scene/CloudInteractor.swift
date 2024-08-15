//
//  ClouudInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import Alamofire

class CloudInteractor: CloudSceneInteractorInput {
 
  var presenter: CloudScenePresenterInput?
  var fetchWorker: CloudSceneFetchingNetworkLogic?
  private let baseUrl = "https://dummyjson.com/todos"
  
  func tryFetchingTodos() {
    fetchWorker?.fetchTasks(from: baseUrl) { [self] result in
      switch result {
      case .success(let entities):
        let responseEntities = entities
        presenter?.showTodos(todos: responseEntities.todos)
      case .failure(let error):
        presenter?.showError(error: error)
      }
    }
  }
}

