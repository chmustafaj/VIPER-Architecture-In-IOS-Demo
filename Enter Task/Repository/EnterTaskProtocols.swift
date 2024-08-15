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
  func startAddingTaskToList(taskName: String)
}

protocol EnterTaskPresenterToViewProtocol: AnyObject {
  func showTaskAdded()
  func showError()
}

protocol EnterTaskPresenterToInteractorProtocol: AnyObject {
  func addTaskToList(listWeAreAddingTaskTo: String, taskName: String, resultHandler: @escaping ((Bool)->Void))
}

protocol EnterTaskPresenterToRouterProtocol: AnyObject {
  func createModule(listWeAreAddingToId: String) -> EntryViewController
}
