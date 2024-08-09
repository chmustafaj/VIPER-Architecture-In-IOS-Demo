//
//  TasksInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalInteractor: LocalPresenterToInteractorProtocol{
  
  weak var presenter: LocalInteractorToPresenterProtocol?
  private var tasks = [Task]()
  
  func fetchTasks(listId: String) {
    let list = getListFromId(id: listId)
    do{
      print("getting data")
      let allTasks = try NetworkManager.networkManagerContext.fetch(Task.fetchRequest())
      print(allTasks)
      
      tasks = allTasks.filter({ $0.group == list})
      let tasksModels = convertTasksEntitiesToViewModels(tasksEntities: tasks)
      self.presenter?.tasksFetchedSuccess(tasksModelArray: tasksModels)
    }
    catch {
      print("Cannot get data")
      self.presenter?.tasksFetchFailed()
    }
  }
  
  func deleteTask(_ taskToDeleteId: String) {
    let taskToDelete = getTaskFromId(id: taskToDeleteId)
    NetworkManager.networkManagerContext.delete(taskToDelete)
    do{
      try NetworkManager.networkManagerContext.save()
    }
    catch {
      print("error deleting")
    }
  }
  
  func toggleTaskIsComplete(_ taskToToggleId: String, _ isComplete: Bool) {
    let taskToToggle = getTaskFromId(id: taskToToggleId)
    taskToToggle.isComplete = isComplete
    do {
      try NetworkManager.networkManagerContext.save()
    } catch {
      print("Failed to save task")
    }
  }
}

extension LocalInteractor {
  func getListFromId(id: String) -> Group{
    do{
      print("getting data")
      let allLists = try NetworkManager.networkManagerContext.fetch(Group.fetchRequest())
      print(allLists)
      for list in allLists {
        if(list.name == id){
          return list
        }
      }
    }
    catch {
      print("Cannot get data")
      self.presenter?.tasksFetchFailed()
    }
    return Group()
  }
  
  
  func getTaskFromId(id: String) ->Task {
    do{
      print("getting data")
      let allTasks = try NetworkManager.networkManagerContext.fetch(Task.fetchRequest())
      print(allTasks)
      for task in allTasks {
        if(task.name == id){
          return task
        }
      }
    }
    catch {
      print("Cannot get data")
      self.presenter?.tasksFetchFailed()
    }
    return Task()
  }
  
  func convertTasksEntitiesToViewModels(tasksEntities: [Task]) -> [TaskViewModel] {
    var taskViewModels = [TaskViewModel]()
    for task in tasksEntities {
      let taskVM = TaskViewModel(name: task.name!, isComplete: task.isComplete)
      taskViewModels.append(taskVM)
    }
    return taskViewModels
    
  }
}
