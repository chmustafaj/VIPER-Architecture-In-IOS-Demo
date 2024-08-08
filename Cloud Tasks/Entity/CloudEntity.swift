//
//  ToDo.swift
//  TODO List
//
//  Created by Mustafa Jawad on 6/8/2024.
//

import Foundation
struct Todo: Codable {
  let id: Int
  let todo: String
  var completed: Bool
  let userId: Int
}

struct TodosResponse: Codable {
  let todos: [Todo]
  let total: Int
  let skip: Int
  let limit: Int
  
  func toToDoModels() -> [ToDoModel] {
    return todos.map { ToDoModel(todo: $0.todo, isComplete: $0.completed) }
  }
}
