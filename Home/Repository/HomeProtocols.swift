//
//  HomeRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import UIKit

protocol HomeViewToPresenterProtocol: AnyObject {
  var view: HomePresenterToViewProtocol? {get set}
  var interactor: HomePresenterToInteractorProtocol? {get set}
  var router: HomePresenterToRouterProtocol? {get set}
  func startFetchingList()
  func startDeletingListItem(id: String)
  func startLoadingTasksScreen(listId: String)
}

protocol HomePresenterToViewProtocol: AnyObject {
  func showLists(listsArray: [ListViewModel])
  func showError()
  
}
protocol HomePresenterToInteractorProtocol: AnyObject {
  func fetchList(handleResult: @escaping ([Group])->Void)
  func deleteListItem(listItemId: String)
}

protocol HomePresenterToRouterProtocol: AnyObject {
  func createModule() -> HomeViewController
  func startLoadingTasksScreen(listId: String)
  var viewController: UIViewController? {get set}
}


