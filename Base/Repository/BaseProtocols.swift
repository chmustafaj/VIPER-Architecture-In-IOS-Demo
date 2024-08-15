//
//  BaseProtocols.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
 

protocol BaseViewToPresenterProtocol: AnyObject {
  var view: BasePresenterToViewProtocol? {get set}
  var interactor: BasePresenterToInteractorProtocol? {get set}
  var router: BasePresenterToRouterProtocol? {get set}
  func startCreatingList(name: String)
}

protocol BasePresenterToViewProtocol: AnyObject {
  func showListAdded(listsArray: [ListViewModel])
  func showError()  
}
protocol BasePresenterToInteractorProtocol: AnyObject {
  var presenter: BaseInteractorToPresenterProtocol? {get set}
  func addList(name: String)
}

protocol BasePresenterToRouterProtocol: AnyObject {
  func createModule() -> BaseViewController
  func createHomeViewController() -> HomeViewController
  func createCloudViewController() -> CloudViewController
}

protocol BaseInteractorToPresenterProtocol: AnyObject {
  func listsAddedSuccess(listEntities: [Group])
  func listsAddedFailed()
}
