//
//  ClouudInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import UIKit
import Alamofire

class CloudInteractor: CloudPresenterToInteractorProtocol {

  static let shared = CloudInteractor()
  private let baseUrl = "https://dummyjson.com/todos"
  
  func fetchToDos(success: @escaping (Result) -> Void) {
    AF.request(baseUrl, method: .get).responseDecodable(of: TodosResponse.self) { response in
      switch response.result {
      case .success(let todoResponse):
        let models = todoResponse.toToDoModels()
        success(Result.success(models))
      case .failure(let error):
        success(Result.failure(error))
      }
    }
  }
}

