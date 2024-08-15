//
//  Protocols.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit
import CoreData

protocol LocalViewToPresenterProtocol: AnyObject{
  
  var view: LocalPresenterToViewProtocol? {get set}
  var interactor: LocalPresenterToInteractorProtocol? {get set}
  var router: LocalPresenterToRouterProtocol? {get set}
  func startFetchingToDos()
  func deleteItemRequested(taskToDeleteId: String)
  func toggleTaskIsCompleteRequest(taskToToggleId: String, isComplete: Bool)
  func startLoadingEnterTaskScreen(update: @escaping (()->Void))
}


protocol LocalPresenterToViewProtocol: AnyObject {
  func showTasks(tasksArray: [TaskViewModel])
  func showError()
}

protocol LocalPresenterToRouterProtocol: AnyObject {
  func createModule(selectedGroupId: String) -> TasksViewController
  func createEntryModule(listToAddTaskToId: String, update: @escaping (()->Void))
  var viewController: UIViewController? {get set}
}

protocol LocalPresenterToInteractorProtocol: AnyObject {
  func fetchTasks(listId: String, handleResult: @escaping ([Task])->Void)
  func deleteTask(_ taskToDeleteId: String)
  func toggleTaskIsComplete(_ taskToToggleId: String, _ isComplete: Bool)
}

protocol DataManagerProtocol {
  var dataManagerContext: NSManagedObjectContext? {get}
  func fetchAllTasks() -> [Task]?
  func fetchLists() -> [Group]?
  func deleteTask(taskToDelete: Task)
  func toggleTaskIsComplete(task: Task, isComplete: Bool)
  func addTask(taskName: String, listToAddTo: Group) -> Bool
}

