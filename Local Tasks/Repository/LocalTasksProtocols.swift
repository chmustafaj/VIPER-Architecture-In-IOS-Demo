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
  func startFetchingToDos(selectedListId: String)
  func deleteItemRequested(taskToDeleteId: String)
  func toggleTaskIsCompleteRequest(taskToToggleId: String, isComplete: Bool)
  
}


protocol LocalPresenterToViewProtocol: AnyObject {
  func showTasks(tasksArray: [TaskViewModel])
  func showError()
}

protocol LocalPresenterToRouterProtocol: AnyObject {
  static func createModule(selectedGroupId: String) -> TasksViewController
  static func createEntryModule(listToAddTaskToId: String) -> EntryViewController
}

protocol LocalPresenterToInteractorProtocol: AnyObject {
  var presenter:LocalInteractorToPresenterProtocol? {get set}
  func fetchTasks(listId: String)
  func deleteTask(_ taskToDeleteId: String)
  func toggleTaskIsComplete(_ taskToToggleId: String, _ isComplete: Bool)
}

protocol LocalInteractorToPresenterProtocol: AnyObject {
  func tasksFetchedSuccess(tasksModelArray: [TaskViewModel])
  func tasksFetchFailed()
}
