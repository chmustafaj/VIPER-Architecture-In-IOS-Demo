//
//  Protocols.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
protocol LocalViewToPresenterProtocol: AnyObject{
  
  var view: LocalPresenterToViewProtocol? {get set}
  var interactor: LocalPresenterToInteractorProtocol? {get set}
  var router: LocalPresenterToRouterProtocol? {get set}
  func startFetchingToDos(selectedList: Group)
  func deleteItemRequested(itemToDelete: Task)
  func toggleTaskIsCompleteRequest(taskToToggle: Task, isComplete: Bool)
  
}

protocol LocalPresenterToViewProtocol: AnyObject{
  func showTasks(tasksArray:Array<Task>)
  func showError()
}

protocol LocalPresenterToRouterProtocol: AnyObject {
  static func createModule(selectedGroup: Group)-> TasksViewController
  static func createEntryModule(listToAddTaskTo: Group) -> EntryViewController
}

protocol LocalPresenterToInteractorProtocol: AnyObject {
  var presenter:LocalInteractorToPresenterProtocol? {get set}
  func fetchTasks(list: Group)
  func deleteTask(_ taskToDelete: Task)
  func toggleTaskIsComplete(_ taskToToggle: Task, _ isComplete: Bool)
}

protocol LocalInteractorToPresenterProtocol: AnyObject {
  func tasksFetchedSuccess(tasksModelArray:Array<Task>)
  func tasksFetchFailed()
}
