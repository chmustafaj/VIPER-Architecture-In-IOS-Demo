//
//  HomePresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation

class HomePresenter: HomeScenePresenterInput {

  weak var viewController: HomeScenePresenterOutput?

  func showListEntities(listsArray: [Group]) {
    viewController?.showLists(listsArray: convertEntityToViewModel(groupEntites: listsArray))
  }
  
  func showError() {
    viewController?.showError()
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
