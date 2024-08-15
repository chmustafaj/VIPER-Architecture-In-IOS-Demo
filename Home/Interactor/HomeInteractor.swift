//
//  HomeInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation
class HomeInteractor: HomePresenterToInteractorProtocol {

  private let dataManager: DataManagerProtocol
  
  init(dataManager: DataManagerProtocol){
    self.dataManager = dataManager
  }
  
  func fetchList(handleResult: @escaping ([Group])->Void) {
    do {
      print("Getting data")
      let groups = try dataManager.dataManagerContext!.fetch(Group.fetchRequest())
      handleResult(groups)
    } catch {
      handleResult([Group]())
      print("Cannot get data")
    }
  }
  
  func deleteListItem(listItemId: String) {
    do {
      print("Getting data")
      let groups = try dataManager.dataManagerContext!.fetch(Group.fetchRequest())
      for group in groups {
        if(group.name == listItemId){
          dataManager.dataManagerContext!.delete(group)
          do {
            try dataManager.dataManagerContext!.save()
          } catch {
            print("Error saving")
          }
        }
      }
    }catch {
      print("Cannot get data")
    }
  }
}

