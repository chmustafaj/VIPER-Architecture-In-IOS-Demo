//
//  Router.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalRouter:LocalPresenterToRouterProtocol{
  
  static func createEntryModule(listToAddTaskTo: Group) -> EntryViewController {
    let entryVC = EntryViewController(list: listToAddTaskTo)
    //    entryVC.update = {
    //      self.getAllItems()
    //      DispatchQueue.main.async {
    //        self.tableView.reloadData()
    //      }
    //    }
//    let navController = UINavigationController(rootViewController: entryVC)
//    navController.modalPresentationStyle = .fullScreen
//    present(navController, animated: true, completion: nil)
    return entryVC
  }
  
  
  
  static func createModule(selectedGroup: Group) -> TasksViewController {
    let view = TasksViewController(list: selectedGroup)
    
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
