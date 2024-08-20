//
//  TODO_ListTests.swift
//  TODO ListTests
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import XCTest
@testable import TODO_List

final class TODO_ListViewTests: XCTestCase {
  
  var sut: HomeViewController!
  var interactorSpy: CreateHomeSceneInteractorSpy!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = HomeViewController()
    interactorSpy = CreateHomeSceneInteractorSpy()
  }
  
  class CreateHomeSceneInteractorSpy: HomeSceneInteractorInput {
    var startedFetchingList = false
    var startedDeletingitem = false
    
    func startFetchingList() {
      startedFetchingList = true
    }
    
    func startDeletingListItem(id: String) {
      startedDeletingitem = true
    }
  }
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    sut = nil
    interactorSpy = nil
  }
  
  func testShouldLoadListOnViewAppears() {
    sut.interactor = interactorSpy
    sut.fetchLists()
    XCTAssertTrue(interactorSpy.startedFetchingList, "Home view controller should ask the interactor to fetch the lists")
  }
}
