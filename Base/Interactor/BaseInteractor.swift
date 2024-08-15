//
//  BaseInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 9/8/2024.
//

import Foundation
import UIKit
class BaseInteractor: BasePresenterToInteractorProtocol {
  weak var presenter: (any BaseInteractorToPresenterProtocol)?
  let dataManager: DataManagerProtocol
  
  init(dataManager: DataManagerProtocol) {
    self.dataManager = dataManager
  }
  
  func addList(name: String) {
    let newItem = Group(context: dataManager.dataManagerContext!)
    newItem.name = name
    do {
      print("Saving")
      try dataManager.dataManagerContext!.save()
    } catch {
      print("Error saving")
      presenter?.listsAddedFailed()
    }
    
    do {
      print("Getting data")
      let entities = try dataManager.dataManagerContext!.fetch(Group.fetchRequest())
      presenter?.listsAddedSuccess(listEntities: entities)
    } catch {
      print("Cannot get data")
      presenter?.listsAddedFailed()
    }
  }
}

