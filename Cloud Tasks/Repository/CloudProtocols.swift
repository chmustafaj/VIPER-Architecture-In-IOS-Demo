//
//  CloudProtocols.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import Alamofire

protocol CloudViewToPresenterProtocol: AnyObject{
  
  var view: CloudPresenterToViewProtocol? {get set}
  var interactor: CloudPresenterToInteractorProtocol? {get set}
  var router: CloudPresenterToRouterProtocol? {get set}
  func startFetchingToDos()
  
}

protocol CloudPresenterToViewProtocol: AnyObject{
  func showToDos(tasksArray: [ToDoModel])
  func showError(error: AFError)
}

protocol CloudPresenterToRouterProtocol: AnyObject {
  static func createModule(selectedGroup: Group)-> CloudViewController
}

protocol CloudPresenterToInteractorProtocol: AnyObject {
  var presenter:CloudInteractorToPresenterProtocol? {get set}
  func fetchToDos()
}

protocol CloudInteractorToPresenterProtocol: AnyObject {
  func todosFetchedSuccess(tasksModelArray: [ToDoModel])
  func tasksFetchFailed(error: AFError)
}
