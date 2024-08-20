//
//  ToDo.swift
//  TODO List
//
//  Created by Mustafa Jawad on 6/8/2024.
//

import Foundation
struct TodoEntity: Codable, Equatable {
  let id: Int
  let todo: String
  var completed: Bool
  let userId: Int
}

struct TodosResponse: Codable {
  let todos: [TodoEntity]
  let total: Int
  let skip: Int
  let limit: Int
}
