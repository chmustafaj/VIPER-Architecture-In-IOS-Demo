//
//  CloudPresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import Alamofire

class CloudPresenter: CloudViewToPresenterProtocol {

  weak var view: CloudPresenterToViewProtocol?
  var interactor: CloudPresenterToInteractorProtocol?
  var router: CloudPresenterToRouterProtocol?
  
  func startFetchingToDos() {
    interactor?.fetchToDos()
  }
  
}
extension CloudPresenter: CloudInteractorToPresenterProtocol {
  func todosFetchedSuccess(tasksModelArray: Array<ToDoModel>) {
    view?.showToDos(tasksArray: tasksModelArray)
  }
  
  func tasksFetchFailed(error: Alamofire.AFError) {
    view?.showError(error: error)
  }
}
