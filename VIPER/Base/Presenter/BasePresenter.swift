//
//  BasePresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

class BasePresenter: BaseViewToPresenterProtocol {
  weak var view: BasePresenterToViewProtocol?
  var interactor: BasePresenterToInteractorProtocol?
  var router: BasePresenterToRouterProtocol?
  
  func startCreatingList(name: String) {
    interactor?.addList(name: name)
  }
}

extension BasePresenter: BaseInteractorToPresenterProtocol {
  func listsAddedSuccess(listEntities: [Group]) {
    let listViewModels = toListViewModels(groups: listEntities)
    view?.showListAdded(listsArray: listViewModels)
  }
  
  func listsAddedFailed() {
    view?.showError()
  }
}

// MARK: - Helper functions
extension BasePresenter {
  func toListViewModels( groups: [Group] ) -> [ListViewModel] {
    var listViewModels = [ListViewModel]()
    for group in groups {
      var listVM = ListViewModel()
      if let groupName = group.name {
        listVM.name = groupName
        if let groupTasks = group.tasks as? Set<Task> {
          listVM.tasks = groupTasks
        }else{
          debugPrint("Group tasks are nil!")
        }
      }else{
        debugPrint("Group name is nil!")
      }
      listViewModels.append(listVM)
    }
    return listViewModels
  }
}
