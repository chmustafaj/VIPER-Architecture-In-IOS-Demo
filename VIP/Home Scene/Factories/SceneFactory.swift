//
//  SceneFactory.swift
//  TODO List
//
//  Created by Mustafa Jawad on 15/8/2024.
//

import Foundation
import UIKit

class DefaultSceneFactory: SceneFactory {
  var configurator: HomeSceneConfigurator!
  
  func makeHomeScene() -> UIViewController {
    let vc = HomeViewController()
    return configurator.configured(vc)
  }
}
