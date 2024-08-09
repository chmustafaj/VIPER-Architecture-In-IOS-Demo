//
//  HomeRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation

protocol HomeViewToPresenterProtocol: AnyObject {
  var view: HomePresenterToViewProtocol? {get set}
  var interactor: HomePresenterToInteractorProtocol? {get set}
  var router: HomePresenterToRouterProtocol? {get set}
  func startFetchingList()
  func startDeletingListItem(id: String)
}

protocol HomePresenterToViewProtocol: AnyObject {
  func showLists(listsArray: [ListViewModel])
  func showError()
  
}
protocol HomePresenterToInteractorProtocol: AnyObject {
  var presenter: HomeInteractorToPresenterProtocol? {get set}
  func fetchList()
  func deleteListItem(listItemId: String)
}

protocol HomePresenterToRouterProtocol: AnyObject {
    func createModule() -> HomeViewController
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
  func listsFetchedSuccess(listsModelArray: [ListViewModel])
  func listsFetchedFailed(error: String)
}
