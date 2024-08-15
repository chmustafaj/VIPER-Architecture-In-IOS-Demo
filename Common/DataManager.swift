//
//  DataManager.swift
//  TODO List
//
//  Created by Mustafa Jawad on 13/8/2024.
//

import Foundation
import CoreData
import UIKit

class DataManager: DataManagerProtocol {
  
  var dataManagerContext: NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func addTask(taskName: String, listToAddTo: Group) -> Bool {
    let taskToSave = Task(context: dataManagerContext!)
    taskToSave.name = taskName
    taskToSave.isComplete = false
    taskToSave.group = listToAddTo
    taskToSave.createdAt = Date()
    do{
      try dataManagerContext!.save()
      return true  // Success = true
    }
    catch {
      print("error saving")
      return false
    }
  }
  
  func deleteTask(taskToDelete: Task) {
    dataManagerContext!.delete(taskToDelete)
    do{
      try dataManagerContext!.save()
    }
    catch {
      print("error deleting")
    }
  }
  
  func toggleTaskIsComplete(task: Task, isComplete: Bool) {
    task.isComplete = isComplete
    do {
      try dataManagerContext!.save()
    } catch {
      print("Failed to save task")
    }
  }
  
  func fetchAllTasks() -> [Task]? {
    do{
      print("getting data")
      let allTasks = try dataManagerContext!.fetch(Task.fetchRequest())
      return allTasks
    }catch {
      debugPrint("Error")
      return nil
    }
  }
  
  func fetchLists() -> [Group]? {
    do{
      print("getting data")
      let allLists = try dataManagerContext!.fetch(Group.fetchRequest())
      return allLists
    }catch {
      debugPrint("Error")
      return nil
    }
  }

  
}
