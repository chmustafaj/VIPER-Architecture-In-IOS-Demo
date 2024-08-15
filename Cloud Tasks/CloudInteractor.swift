//
//  ClouudInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import Alamofire

class CloudInteractor: CloudPresenterToInteractorProtocol {
  private let networkManager: NetworkManagerProtocol
  private let baseUrl = "https://dummyjson.com/todos"
  
  init(networkManager: NetworkManagerProtocol) {
    self.networkManager = networkManager
  }
  
  func fetchToDos(handleResult: @escaping (MyResult) -> Void) {
    networkManager.fetchData(from: baseUrl) { result in  // this result is coming from the fetch data function
      switch result {
      case .success(let entities):
        let responseEntities = entities
        handleResult(MyResult.success(responseEntities.todos))
      case .failure(let error):
        handleResult(MyResult.failure(error))
      }
    }
  }
}

