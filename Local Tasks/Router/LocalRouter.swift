//
//  Router.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalRouter:LocalPresenterToRouterProtocol{
  
  static func createEntryModule(listToAddTaskToId: String) -> EntryViewController {
    let entryVC = EntryViewController(listToAddTaskToId: listToAddTaskToId)
//        entryVC.update = {
//          self.getAllItems()
//          DispatchQueue.main.async {
//            self.tableView.reloadData()
//          }
//        }
//    let navController = UINavigationController(rootViewController: entryVC)
//    navController.modalPresentationStyle = .fullScreen
//    present(navController, animated: true, completion: nil)
    return entryVC
  }
  
  
  
  static func createModule(selectedGroupId: String) -> TasksViewController {
    
    let view = TasksViewController(listId: selectedGroupId)
    
    let presenter: LocalViewToPresenterProtocol & LocalInteractorToPresenterProtocol = LocalPresenter()
    let interactor: LocalPresenterToInteractorProtocol = LocalInteractor()
    let router:LocalPresenterToRouterProtocol = LocalRouter()
    
    view.presentor = presenter
    presenter.view = view
    presenter.router = router
    presenter.interactor = interactor
    interactor.presenter = presenter
    
    return view
    
  }
}
