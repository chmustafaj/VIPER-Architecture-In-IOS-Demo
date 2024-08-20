//
//  HomeDataWorker.swift
//  TODO List
//
//  Created by Mustafa Jawad on 15/8/2024.
//

import Foundation
import CoreData
import UIKit

class HomeDataWorker: HomeSceneFetchingDataLogic {
  
  var dataWorkerContext: NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

  func fetchLists() -> [Group]? {
    do{
      print("getting data")
      let allLists = try dataWorkerContext!.fetch(Group.fetchRequest())
      return allLists
    }catch {
      debugPrint("Error")
      return nil
    }
  }
  
  func deleteListItem(id: String) {
    do {
      print("Getting data")
      let groups = try dataWorkerContext!.fetch(Group.fetchRequest())
      for group in groups {
        if(group.name == id){
          dataWorkerContext!.delete(group)
          do {
            try dataWorkerContext!.save()
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
