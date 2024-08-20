//
//  Seeds.swift
//  TODO ListCloudTests
//
//  Created by Mustafa Jawad on 19/8/2024.
//

import Foundation
import XCTest
@testable import TODO_List
class CloudSeeds {
  let todo1 = TodoEntity(id: 1, todo: "Mock todo 1", completed: false, userId: 1)
  let todo2 = TodoEntity(id: 2, todo: "Mock todo 2", completed: false, userId: 1)
  public let mockTodoEntities: [TodoEntity]
  init() {
    mockTodoEntities = [todo1, todo2]
  }
}

