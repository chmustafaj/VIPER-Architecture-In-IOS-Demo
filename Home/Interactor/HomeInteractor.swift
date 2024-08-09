//
//  HomeInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation

class HomeInteractor: HomePresenterToInteractorProtocol {
  weak var presenter: HomeInteractorToPresenterProtocol?
  
  func fetchList() {
    do {
      print("Getting data")
      let groups = try NetworkManager.networkManagerContext.fetch(Group.fetchRequest())
      let ListViewModels = toListViewModels(groups: groups)
      presenter?.listsFetchedSuccess(listsModelArray: ListViewModels)
    } catch {
      presenter?.listsFetchedFailed(error: "Cannot get data")
      print("Cannot get data")
    }
  }
  
  func deleteListItem(listItemId: String) {
    do {
      print("Getting data")
      let groups = try NetworkManager.networkManagerContext.fetch(Group.fetchRequest())
      for group in groups {
        if(group.name == listItemId){
          NetworkManager.networkManagerContext.delete(group)
          do {
            try NetworkManager.networkManagerContext.save()
          } catch {
            print("Error saving")
          }
        }
      }
    }catch {
      presenter?.listsFetchedFailed(error: "Cannot get data")
      print("Cannot get data")
    }
  }
}

extension HomeInteractor {
  
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
