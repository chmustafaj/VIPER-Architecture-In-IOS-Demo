//
//  Router.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalRouter:PresenterToRouterProtocol{
    
  static func createModule(selectedList: Group) -> TasksViewController {
      let view = TasksViewController(list: selectedList)
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = LocalPresenter()
        let interactor: PresenterToInteractorProtocol = LocalInteractor()
        let router:PresenterToRouterProtocol = LocalRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
        
        let movieModue = MovieRouter.createMovieModule()
        navigationController.pushViewController(movieModue,animated: true)
        
    }
    
}
view raw
