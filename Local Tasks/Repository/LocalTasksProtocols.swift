//
//  Protocols.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
protocol ViewToPresenterProtocol: AnyObject{
  
  var view: PresenterToViewProtocol? {get set}
  var interactor: PresenterToInteractorProtocol? {get set}
  var router: PresenterToRouterProtocol? {get set}
  func startFetchingToDos(selectedList: Group)
  func deleteItemRequested(itemToDelete: Task)
  func toggleTaskIsCompleteRequest(taskToToggle: Task, isComplete: Bool)
  
}

protocol PresenterToViewProtocol: AnyObject{
  func showTasks(tasksArray:Array<Task>)
  func showError()
}

protocol PresenterToRouterProtocol: AnyObject {
  static func createModule(selectedGroup: Group)-> TasksViewController
  static func createEntryModule(listToAddTaskTo: Group) -> EntryViewController
}

protocol PresenterToInteractorProtocol: AnyObject {
  var presenter:InteractorToPresenterProtocol? {get set}
  func fetchTasks(list: Group)
  func deleteTask(_ taskToDelete: Task)
  func toggleTaskIsComplete(_ taskToToggle: Task, _ isComplete: Bool)
}

protocol InteractorToPresenterProtocol: AnyObject {
  func tasksFetchedSuccess(tasksModelArray:Array<Task>)
  func tasksFetchFailed()
}
