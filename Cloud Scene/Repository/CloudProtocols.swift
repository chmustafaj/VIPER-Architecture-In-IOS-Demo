//
//  CloudProtocols.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import Alamofire

protocol CloudSceneViewControllerInput: AnyObject {
  func showToDos(tasksArray: [ToDoViewModel])
  func showError(error: AFError)
}

protocol CloudSceneViewControllerOutput: AnyObject {
  func tryFetchingTodos()
}

protocol CloudSceneInteractorOutput: AnyObject {
  func showTodos(todos: [TodoEntity])
  func showError(error: AFError)
}
// MARK: - Worker
protocol CloudSceneFetchingNetworkLogic {
  func fetchTasks(from url: String, completion: @escaping (Result<TodosResponse, AFError>) -> Void)
}

protocol CloudSceneConfigurator {
  func configured(_ vc: CloudViewController) -> CloudViewController
}

typealias CloudSceneInteractorInput = CloudSceneViewControllerOutput
typealias CloudScenePresenterInput = CloudSceneInteractorOutput
typealias CloudScenePresenterOutput = CloudSceneViewControllerInput
