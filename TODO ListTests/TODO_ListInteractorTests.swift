//
//  TODO_ListInteractorTests.swift
//  TODO ListTests
//
//  Created by Mustafa Jawad on 16/8/2024.
//

import XCTest
@testable import TODO_List

final class TODO_ListInteractorTests: XCTestCase {
  
  var sut: HomeInteractor!
  var presenterSpy: HomeScenePresenterSpy!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = HomeInteractor()
    presenterSpy = HomeScenePresenterSpy()
  }
  
  class HomeScenePresenterSpy: HomeScenePresenterInput {
    var lists: [Group]?
    var showListsOrErrorCalled = false
    
    func showListEntities(listsArray: [TODO_List.Group]) {
      showListsOrErrorCalled = true
      lists = listsArray
    }
    
    func showError() {
      showListsOrErrorCalled = true
    }
  }
  
  override func tearDownWithError() throws {
    sut = nil
    presenterSpy = nil
  }
}
