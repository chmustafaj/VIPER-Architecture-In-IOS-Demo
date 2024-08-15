//
//  CloudViewController.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import UIKit
import Alamofire

class CloudViewController: UIViewController {
  // MARK: - Variables
  var presentor: CloudViewToPresenterProtocol?

  private var todos = [ToDoViewModel]()
  // MARK: - UI Elements
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    var indicator = UIActivityIndicatorView()
    indicator = UIActivityIndicatorView(style: .large)
    indicator.center = view.center
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  private let tableView: UITableView = {
    let tb = UITableView()
    tb.backgroundColor = .systemBackground
    tb.allowsSelection = true
    tb.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
    tb.translatesAutoresizingMaskIntoConstraints = false
    return tb
  }()
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupTableView()
    presentor?.startFetchingToDos()
    showProgressIndicator()
  }
  
  // MARK: - Methods
  func setupUI() {
    self.view.addSubview(tableView)
    view.addSubview(activityIndicator)
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
  
  private func showProgressIndicator() {
    activityIndicator.startAnimating()
  }
  
  private func hideProgressIndicator() {
    activityIndicator.stopAnimating()
  }
}

extension CloudViewController: CloudPresenterToViewProtocol {
  func showToDos(tasksArray: [ToDoViewModel]) {
    self.todos = tasksArray
    print(todos)
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.hideProgressIndicator()
    }
  }
  
  func showError(error: AFError) {
    print("Failed to fetch todos:", error)
    hideProgressIndicator()
  }
}
extension CloudViewController: UITableViewDelegate, UITableViewDataSource, TaskCellDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
    cell?.configure(taskName: todos[indexPath.row].todo, isChecked: todos[indexPath.row].isComplete)
    cell?.delegate = self
    return cell!
  }
  
  func taskCell(_ cell: TaskCell, didChangeCheckboxState: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    var task = todos[indexPath.row]
    task.isComplete = didChangeCheckboxState
  }
}
