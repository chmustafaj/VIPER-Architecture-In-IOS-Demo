//
//  BaseInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

class BaseInteractor: BasePresenterToInteractorProtocol {
  var presenter: (any BaseInteractorToPresenterProtocol)?
  
  func addList(name: String) {
    let newItem = Group(context: NetworkManager.networkManagerContext)
    newItem.name = name
    do {
      print("Saving")
      try NetworkManager.networkManagerContext.save()
    } catch {
      print("Error saving")
      presenter?.listsAddedFailed()
    }
    
    do {
      print("Getting data")
      let entities = try NetworkManager.networkManagerContext.fetch(Group.fetchRequest())
      let models = toListViewModels(groups: entities)
      presenter?.listsAddedSuccess(listsModelArray: models)
    } catch {
      print("Cannot get data")
      presenter?.listsAddedFailed()
    }
  }
}

extension BaseInteractor {
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
