//
//  HomePresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation

class HomePresenter: HomeViewToPresenterProtocol {
  func startLoadingTasksScreen(listId: String) {
    router?.startLoadingTasksScreen(listId: listId)
  }
  
  weak var view: HomePresenterToViewProtocol?
  
  var interactor: HomePresenterToInteractorProtocol?
  
  var router: HomePresenterToRouterProtocol?
  
  func startFetchingList() {
    interactor?.fetchList()
  }
  
  func startDeletingListItem(id: String) {
    interactor?.deleteListItem(listItemId: id)
  }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
  func listsFetchedSuccess(listsModelArray: [ListViewModel]) {
    view?.showLists(listsArray: listsModelArray)
  }
  
  func listsFetchedFailed(error: String) {
    view?.showError()
  }
}
