//
//  NetworkManaget.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
  
  func fetchData<T:Decodable> (from url: String, completion: @escaping (Result<T, Alamofire.AFError>) -> Void) {
    AF.request(url, method: .get).responseDecodable(of: T.self) { response in
      completion(response.result)
    }
  }
}
