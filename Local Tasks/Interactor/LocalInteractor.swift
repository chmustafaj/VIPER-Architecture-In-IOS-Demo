//
//  TasksInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit
class LocalInteractor: PresenterToInteractorProtocol{
  var presenter: InteractorToPresenterProtocol?
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  let list: Group? = nil  // TODO: Initialise this
  private var tasks = [Task]()

  func fetchTasks() {
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
}
