//
//  ViewController.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import UIKit


class HomeViewController: UIViewController {
  // MARK: - Variables
  private var models = [ListViewModel]()
  var interactor: HomeSceneInteractorInput?
  var router: HomeSceneRoutingLogic?
  // MARK: - UI Elements
  private let tableView: UITableView = {
    let tb = UITableView()
    tb.backgroundColor = .systemBackground
    tb.allowsSelection = true
    tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tb.translatesAutoresizingMaskIntoConstraints = false
    return tb
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupTableView()
    fetchLists()
  }
  
  func fetchLists() {
    interactor?.startFetchingList()
  }
  
  // MARK: - Methods
  private func setupUI() {
    self.title = "Lists"
    self.view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
    ])
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  func updateListView(items: [ListViewModel]) {
    self.models = items
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

extension HomeViewController: HomeSceneViewControllerInput {
  func showLists(listsArray: [ListViewModel]) {
    models = listsArray
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func showError() {
    debugPrint("Error")
  }
}

// MARK: - Delegate Methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = models[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let listToDelete = models[indexPath.row]
      interactor?.startDeletingListItem(id: listToDelete.name)
      models.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedList = models[indexPath.row]
    router?.startLoadingTasksScreen(listId: selectedList.name)
  }
}
