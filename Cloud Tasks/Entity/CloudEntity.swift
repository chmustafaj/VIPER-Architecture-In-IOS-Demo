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
}
