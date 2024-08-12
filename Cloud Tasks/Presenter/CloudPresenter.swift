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
    interactor?.fetchToDos() { result in
      switch(result) {
      case .success(let models):
        self.view?.showToDos(tasksArray: models)
      case .failure(let error):
        self.view?.showError(error: error)
      }
    }
  }
}
