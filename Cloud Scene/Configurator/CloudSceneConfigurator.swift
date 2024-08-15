//
//  CloudRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
import UIKit

class DefultCloudSceneConfigurator: CloudSceneConfigurator {
  func configured(_ vc: CloudViewController) -> CloudViewController {
    let fetchWorker = CloudSceneFetchTasksWorker()
    let interactor = CloudInteractor()
    let presenter = CloudPresenter()
    presenter.viewController = vc
    interactor.presenter = presenter
    interactor.fetchWorker = fetchWorker
    vc.interactor = interactor
    return vc
  }
}
