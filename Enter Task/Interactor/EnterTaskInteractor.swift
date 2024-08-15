//
//  EnterTaskInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
class EnterTaskInteractor: EnterTaskPresenterToInteractorProtocol {

  private let dataManager: DataManagerProtocol
  
  init(dataManager: DataManagerProtocol) {
    self.dataManager = dataManager
  }
  func addTaskToList(listWeAreAddingTaskTo: String, taskName: String, resultHandler: (Bool)->Void) {
    let group = getGroupFromId(listId: listWeAreAddingTaskTo)
    resultHandler(dataManager.addTask(taskName: taskName, listToAddTo: group!))
  }
}

// MARK: - Helper functions
extension EnterTaskInteractor {
  func getGroupFromId(listId: String) -> Group? {
    print("getting data")
    if let allLists = dataManager.fetchLists(){
      print(allLists)
      for list in allLists {
        if(list.name == listId){
          return list
        }
      }
    }else{
      return nil
    }
    return nil
  }
}
