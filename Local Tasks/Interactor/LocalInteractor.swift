//
//  TasksInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalInteractor: LocalPresenterToInteractorProtocol{
  
  private let dataManager: DataManagerProtocol
  private var tasks = [Task]()
  // Dependency injection: We are expecting a Protocol, but we are passing an implementation from the initialiser
  init(dataManager: DataManagerProtocol) {
    self.dataManager = dataManager
  }
  
  func fetchTasks(listId: String, handleResult: @escaping ([Task])->Void) {
    if let list = getListFromId(id: listId) {
      if let allTasks = dataManager.fetchAllTasks(){
        print(allTasks)
        tasks = allTasks.filter({ $0.group == list})
        handleResult(tasks)
      }else {
        handleResult([Task]())
      }
    }
  }
  
  func deleteTask(_ taskToDeleteId: String) {
    if let taskToDelete = getTaskFromId(id: taskToDeleteId) {
      dataManager.deleteTask(taskToDelete: taskToDelete)
    } else{
      debugPrint("Error")
    }
  }
  
  func toggleTaskIsComplete(_ taskToToggleId: String, _ isComplete: Bool) {
    if let taskToToggle = getTaskFromId(id: taskToToggleId) {
      dataManager.toggleTaskIsComplete(task: taskToToggle, isComplete: isComplete)
    }
  }
}

// MARK: - Helper functions
extension LocalInteractor {
  func getListFromId(id: String) -> Group? {
    if let allLists = dataManager.fetchLists() {
      print(allLists)
      for list in allLists {
        if(list.name == id){
          return list
        }
      }
    }
    return nil
  }
  func getTaskFromId(id: String) ->Task? {
    do{
      print("getting data")
      if let allTasks = dataManager.fetchAllTasks() {
        print(allTasks)
        for task in allTasks {
          if(task.name == id){
            return task
          }
        }
      }else{
        print("Cannot get data")
        return nil
      }
    }
    return nil
  }
}
