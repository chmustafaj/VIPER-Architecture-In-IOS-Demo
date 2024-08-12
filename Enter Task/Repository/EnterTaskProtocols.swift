//
//  EnterTaskProtocols.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation

protocol EnterTaskViewToPresenterProtocol: AnyObject {
  var view: EnterTaskPresenterToViewProtocol? {get set}
  var interactor: EnterTaskPresenterToInteractorProtocol? {get set}
  var router: EnterTaskPresenterToRouterProtocol? {get set}
  func startAddingTaskToList(listId: String, taskName: String)
}

protocol EnterTaskPresenterToViewProtocol: AnyObject {
  func showTaskAdded()
  func showError()
}

protocol EnterTaskPresenterToInteractorProtocol: AnyObject {
  var presenter: EnterTaskInteractorToPresenterProtocol? {get set}
  func addTaskToList(listId: String, taskName: String)
}

protocol EnterTaskPresenterToRouterProtocol: AnyObject {
  func createModule(listWeAreAddingToId: String) -> EntryViewController
}

protocol EnterTaskInteractorToPresenterProtocol: AnyObject {
  func taskAddedSuccess()
  func taskAddedFailed()
}
