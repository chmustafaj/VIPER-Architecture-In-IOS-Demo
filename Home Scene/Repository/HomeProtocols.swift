//
//  HomeRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import UIKit

protocol HomeSceneViewControllerInput: AnyObject {
  func showLists(listsArray: [ListViewModel])
  func showError()
}

protocol HomeSceneViewControllerOutput: AnyObject {
  func startFetchingList()
  func startDeletingListItem(id: String)
}

protocol HomeSceneInteractorOutput: AnyObject {
  func showListEntities(listsArray: [Group])
  func showError()
}
// MARK: - Worker
protocol HomeSceneFetchingDataLogic {
  func fetchLists() -> [Group]?
  func deleteListItem(id: String)
}

protocol HomeSceneConfigurator {
  func configured(_ vc: HomeViewController) -> HomeViewController
}

protocol HomeSceneRoutingLogic {
  func startLoadingTasksScreen(listId: String)
}

protocol SceneFactory {
  var configurator: HomeSceneConfigurator! { get set }
  func makeHomeScene() -> UIViewController
}

typealias HomeSceneInteractorInput = HomeSceneViewControllerOutput
typealias HomeScenePresenterInput = HomeSceneInteractorOutput
typealias HomeScenePresenterOutput = HomeSceneViewControllerInput



