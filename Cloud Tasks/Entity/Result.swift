//
//  Result.swift
//  TODO List
//
//  Created by Mustafa Jawad on 12/8/2024.
//

import Alamofire

enum Result {
    case success([ToDoModel])
    case failure(AFError)
}
