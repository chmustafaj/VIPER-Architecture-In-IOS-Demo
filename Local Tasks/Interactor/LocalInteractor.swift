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
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  private var tasks = [Task]()
  
  func fetchTasks(list: Group) {
    do{
      print("getting data")
      let allTasks = try context.fetch(Task.fetchRequest())
      print(allTasks)
      
      tasks = allTasks.filter({ $0.group == list})
      
      self.presenter?.tasksFetchedSuccess(tasksModelArray: tasks)
    }
    catch {
      print("Cannot get data")
      self.presenter?.tasksFetchFailed()
    }
  }
  
  func deleteTask(_ taskToDelete: Task) {
    context.delete(taskToDelete)
    do{
      try context.save()
    }
    catch {
      print("error deleting")
    }
  }
  
  func toggleTaskIsComplete(_ taskToToggle: Task, _ isComplete: Bool) {
    taskToToggle.isComplete = isComplete
    do {
      try context.save()
    } catch {
      print("Failed to save task")
    }
  }
}
