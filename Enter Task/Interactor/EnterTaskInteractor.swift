//
//  EnterTaskInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

class EnterTaskInteractor: EnterTaskPresenterToInteractorProtocol {
  weak var presenter: EnterTaskInteractorToPresenterProtocol?
  
  func addTaskToList(listId: String, taskName: String) {
    var taskToSave = Task(context: NetworkManager.networkManagerContext)
    taskToSave.name = taskName
    taskToSave.isComplete = false
    taskToSave.group = getGroupFromId(listId: listId)
    taskToSave.createdAt = Date()
    do{
      try NetworkManager.networkManagerContext.save()
    }
    catch {
      presenter?.taskAddedFailed()
      print("error saving")
    }
    presenter?.taskAddedSuccess()
  }
}

extension EnterTaskInteractor {
  func getGroupFromId(listId: String) -> Group{
    do{
      print("getting data")
      let allLists = try NetworkManager.networkManagerContext.fetch(Group.fetchRequest())
      print(allLists)
      for list in allLists {
        if(list.name == listId){
          return list
        }
      }
    }
    catch {
      print("Cannot get data")
      self.presenter?.taskAddedFailed()
    }
    return Group()
  }
}
