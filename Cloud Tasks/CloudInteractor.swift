//
//  ClouudInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import UIKit
import Alamofire

class CloudInteractor: CloudPresenterToInteractorProtocol{
  static let shared = CloudInteractor()
  private let baseUrl = "https://dummyjson.com/todos"
  weak var presenter: CloudInteractorToPresenterProtocol?  // weak to prevent retain cycle
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func fetchToDos() {
    AF.request(baseUrl, method: .get).responseDecodable(of: TodosResponse.self) { response in
      switch response.result {
      case .success(let todoResponse):
        let models = todoResponse.toToDoModels()
        self.presenter?.todosFetchedSuccess(tasksModelArray: models)
      case .failure(let error):
        self.presenter?.tasksFetchFailed(error: error)
      }
    }
  }
}

