//
//  CloudPresenterTests.swift
//
//
//  Created by Mustafa Jawad on 19/8/2024.
//

import XCTest
@testable import TODO_List

final class CloudPresenterTests: XCTestCase {
  
  var mockToDoEntities: [TodoEntity]!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func testViewModelConversion() {
    // given
    mockToDoEntities = CloudSeeds().mockTodoEntities
    
    // when
    let viewModels = mockToDoEntities.map { ToDoViewModel(todo: $0.todo, isComplete: $0.completed) }
    
    // then
    XCTAssertEqual(viewModels.first?.todo, mockToDoEntities.first?.todo)
  }

}
