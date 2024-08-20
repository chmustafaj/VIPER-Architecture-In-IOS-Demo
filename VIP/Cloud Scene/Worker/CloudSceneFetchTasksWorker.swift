//
//  CloudSceneFetchTasksWorker.swift
//  TODO List
//
//  Created by Mustafa Jawad on 15/8/2024.
//

import Foundation
import Alamofire

class CloudSceneFetchTasksWorker: CloudSceneFetchingNetworkLogic {
  var fetchTasksCalled: Bool!
  
  var resultToReturn: Result<TodosResponse, Alamofire.AFError>!
  
  
  func fetchTasks<T:Decodable> (from url: String, completion: @escaping (Result<T, Alamofire.AFError>) -> Void) {
    AF.request(url, method: .get).responseDecodable(of: T.self) { response in
      completion(response.result)
    }
  }
}
