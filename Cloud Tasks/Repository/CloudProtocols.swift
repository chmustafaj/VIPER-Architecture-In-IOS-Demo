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
  func createModule()-> CloudViewController
}

protocol CloudPresenterToInteractorProtocol: AnyObject {
  func fetchToDos(success: @escaping (Result)->Void)
}
