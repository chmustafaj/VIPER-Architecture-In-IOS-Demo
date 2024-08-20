//
//  TODO_ListCloudTests.swift
//  TODO ListCloudTests
//
//  Created by Mustafa Jawad on 19/8/2024.
//

import XCTest
import Alamofire
@testable import TODO_List

struct MockTodosResponse {
  static func mockSuccess() -> Result<TodosResponse, AFError> {
    let todos = [TodoEntity(id: 1, todo: "Mock todo", completed: false, userId: 1)]
    let todosResponse = TodosResponse(todos: todos, total: 1, skip: 0, limit: 1)
    return .success(todosResponse)
  }
  
  static func mockFailure() -> Result<TodosResponse, AFError> {
    return .failure(AFError.explicitlyCancelled)
  }
}

final class FetchTasksWorkerSpy: CloudSceneFetchingNetworkLogic {
  
  var fetchTasksCalled: Bool! = false
  var resultToReturn: Result<TodosResponse, AFError>!
  func fetchTasks(from url: String, completion: @escaping (Result<TODO_List.TodosResponse, Alamofire.AFError>) -> Void) {
    fetchTasksCalled = true
    let dummyEntities = TodosResponse(todos: CloudSeeds().mockTodoEntities, total: 5, skip: 0, limit: 0)
    completion(.success(dummyEntities))
  }
}

final class FetchTasksWorkerSpyFailiure: CloudSceneFetchingNetworkLogic {
  
  
  var fetchTasksCalled: Bool! = false
  var resultToReturn: Result<TodosResponse, AFError>!
  func fetchTasks(from url: String, completion: @escaping (Result<TODO_List.TodosResponse, Alamofire.AFError>) -> Void) {
    fetchTasksCalled = true
    completion(resultToReturn)
  }
}


final class CloudPresenterSpy: CloudScenePresenterInput {
  var showTodosCalled = false
  var showErrorCalled = false
  func showTodos(todos: [TODO_List.TodoEntity]) {
    showTodosCalled = true
    XCTAssertEqual(todos, CloudSeeds().mockTodoEntities)
  }
  
  func showError(error: Alamofire.AFError) {
    showErrorCalled = true
  }
}

final class TODO_ListCloudTests: XCTestCase {
  
  var sut: CloudInteractor!
  var networkWorker: CloudSceneFetchingNetworkLogic!  // Integration testing
  var workerSpy: CloudSceneFetchingNetworkLogic!
  var presenterSpy: CloudScenePresenterInput!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = CloudInteractor()
    networkWorker = CloudSceneFetchTasksWorker()
    workerSpy = FetchTasksWorkerSpy()
    sut.fetchWorker = workerSpy
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    sut = nil
    networkWorker = nil
    workerSpy = nil
  }
  
  // Integration test
  func testValidAPI() {
    // Given
    let urlString = "https://dummyjson.com/todos"
    let promise = expectation(description: "Data fetch success")
    
    // When
    networkWorker.fetchTasks(from: urlString) { result in
      // Then
      switch result {
      case .success(let entities):
        XCTAssertGreaterThan(entities.total, 0, "Expected more than 0 entities from API.")
        promise.fulfill()
      case .failure(let error):
        XCTFail("API call failed with error: \(error)")
      }
    }
    
    wait(for: [promise], timeout: 10)
  }
  
  // Unit test
  func testFetchTask() {
    let promise = expectation(description: "Data fetch success")
    
    sut.fetchWorker!.fetchTasks(from: "https://dummyjson.com/todos") { result in
      switch result {
      case .success(let entities):
        XCTAssertGreaterThan(entities.total, 0, "Expected more than 0 entities.")
        promise.fulfill()
      case .failure(let error):
        XCTFail("Error: \(error)")
      }
    }
    
    wait(for: [promise], timeout: 5)
    
    XCTAssertTrue(workerSpy.fetchTasksCalled, "Expected fetchTasks() to be called on the worker.")
    
  }
  
  // Unit test with mock success result
  func testFetchTaskSuccess() {
    // Given
    workerSpy = FetchTasksWorkerSpy()
    workerSpy.resultToReturn = MockTodosResponse.mockSuccess()
    let promise = expectation(description: "Data fetch success")
    
    // When
    sut.fetchWorker!.fetchTasks(from: "https://dummyjson.com/todos") { result in
      // Then
      switch result {
      case .success(let entities):
        promise.fulfill()
        XCTAssertGreaterThan(entities.todos.count, 0, "Expected more than 0 entities.")
        self.presenterSpy.showTodos(todos: entities.todos)
      case .failure:
        XCTFail("Expected success, but got failure.")
      }
    }
    
    wait(for: [promise], timeout: 5)
    XCTAssertTrue(workerSpy.fetchTasksCalled, "Expected fetchTasks() to be called on the worker.")
  }
  
  // Unit test with mock failure result
  func testFetchTaskFailure() {
    // Given
    workerSpy = FetchTasksWorkerSpyFailiure()
    workerSpy.resultToReturn = MockTodosResponse.mockFailure()
    let promise = expectation(description: "Data fetch failure")
    sut.fetchWorker = workerSpy
    
    // When
    sut.fetchWorker!.fetchTasks(from: "https://dummyjson.com/todos") { result in
      // Then
      switch result {
      case .success:
        XCTFail("Expected failure, but got success.")
      case .failure(let error):
        XCTAssertTrue(error.isExplicitlyCancelledError, "Expected explicitlyCancelled error.")
        promise.fulfill()
      }
    }
    
    wait(for: [promise], timeout: 5)
    XCTAssertTrue(workerSpy.fetchTasksCalled, "Expected fetchTasks() to be called on the worker.")
  }
}

