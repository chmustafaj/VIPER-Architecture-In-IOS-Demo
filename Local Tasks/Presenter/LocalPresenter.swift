//
//  LocalPresenter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import Foundation
import UIKit

class LocalPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingToDos() {
        interactor?.fetchTasks()
    }
//    
//    func showMovieController(navigationController: UINavigationController) {
//        router?.pushToMovieScreen(navigationConroller:navigationController)
//    }

}

extension LocalPresenter: InteractorToPresenterProtocol{
  
    
    func tasksFetchedSuccess(tasksModelArray: Array<Task>) {
        view?.showTasks(tasksArray: tasksModelArray)
    }
    
    func tasksFetchFailed() {
        view?.showError()
    }
    
}
