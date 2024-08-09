//
//  BasePresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

class BasePresenter: BaseViewToPresenterProtocol {
  var view: BasePresenterToViewProtocol?
  
  var interactor: BasePresenterToInteractorProtocol?
  
  var router: BasePresenterToRouterProtocol?
  
  func startCreatingList(name: String) {
    interactor?.addList(name: name)
  }
  

}

extension BasePresenter: BaseInteractorToPresenterProtocol {
  func listsAddedSuccess(listsModelArray: [ListViewModel]) {
    view?.showListAdded(listsArray: listsModelArray)
  }
  
  func listsAddedFailed() {
    view?.showError()
  }
  
  
}
