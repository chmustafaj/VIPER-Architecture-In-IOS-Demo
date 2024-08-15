//
//  HomeInteractor.swift
//  TODO List
//
//  Created by Mustafa Jawad on 8/8/2024.
//

import Foundation

class HomeInteractor: HomeSceneInteractorInput {
  var presenter: HomeScenePresenterInput?
  var dataWorker: HomeSceneFetchingDataLogic?

  func startDeletingListItem(id: String) {
    dataWorker?.deleteListItem(id: id)
  }

  func startFetchingList() {
    if let lists = dataWorker?.fetchLists() {
      presenter?.showListEntities(listsArray: lists)
    }else {
      presenter?.showError()
    }
  }
  
  func deleteListItem(listItemId: String) {
    dataWorker?.deleteListItem(id: listItemId)
  }
}

