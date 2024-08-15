//
//  HomeSceneConfigurator.swift
//  TODO List
//
//  Created by Mustafa Jawad on 15/8/2024.
//

import Foundation

class DefualtHomeSceneConfigurator: HomeSceneConfigurator {
  
  private var sceneFactory: SceneFactory
  
  init(sceneFactory: SceneFactory) {
    self.sceneFactory = sceneFactory
  }
  
  func configured(_ vc: HomeViewController) -> HomeViewController {
    sceneFactory.configurator = self

    let dataWorker = HomeDataWorker()
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter(sceneFactory: sceneFactory)
    router.source = vc
    presenter.viewController = vc
    interactor.presenter = presenter
    interactor.dataWorker = dataWorker
    vc.interactor = interactor
    vc.router = router
    return vc
  }
}
