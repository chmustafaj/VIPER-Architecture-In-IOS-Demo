//
//  Result.swift
//  TODO List
//
//  Created by Mustafa Jawad on 12/8/2024.
//

import Alamofire

enum MyResult {
    case success([TodoEntity])
    case failure(AFError)
}
