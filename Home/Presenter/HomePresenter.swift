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
    interactor?.fetchList() { listsEntities in
      if listsEntities.isEmpty == false {
        let listViewModels = self.convertEntityToViewModel(groupEntites: listsEntities)
        self.view?.showLists(listsArray: listViewModels)
      }else{
        self.view?.showError()
      }
    }
  }
  
  func startDeletingListItem(id: String) {
    interactor?.deleteListItem(listItemId: id)
  }
}

// MARK: - Helper functions
extension HomePresenter {
  func convertEntityToViewModel(groupEntites: [Group]) -> [ListViewModel] {
    var listViewModels = [ListViewModel]()
    for group in groupEntites {
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
