//
//  HomeRouter.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
import UIKit

class HomeRouter: HomeSceneRoutingLogic {
  weak var source: UIViewController?

   private let sceneFactory: SceneFactory

   init(sceneFactory: SceneFactory) {
     self.sceneFactory = sceneFactory
   }
  
  func startLoadingTasksScreen(listId: String) {
    let taskVC = LocalRouter().createModule(selectedGroupId: listId)
    source?.navigationController?.pushViewController(taskVC, animated: true)
  }
}
