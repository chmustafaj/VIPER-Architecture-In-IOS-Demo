//
//  TasksViewController.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import UIKit

class TasksViewController: UIViewController {
  
  // MARK: - Variables
  var presentor:LocalViewToPresenterProtocol?
  private var tasks = [TaskViewModel]()
  
  // MARK: - UI Elements
  private lazy var activityIndicator: UIActivityIndicatorView = {
    var i = UIActivityIndicatorView()
    i = UIActivityIndicatorView(style: .large)
    i.center = view.center
    i.hidesWhenStopped = true
    return i
  }()
  
  private let tableView: UITableView = {
    let tb = UITableView()
    tb.backgroundColor = .systemBackground
    tb.allowsSelection = true
    tb.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
    tb.translatesAutoresizingMaskIntoConstraints = false
    return tb
  }()
  
  private lazy var btnAdd: UIBarButtonItem = {
    let btn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(presentEntryViewController))
    return btn
  }()
  
  var tasksArrayList = [Task]()
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupUI()
    self.title = "Tasks"
    presentor?.startFetchingToDos()
    showProgressIndicator()
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  private func setupUI() {
    self.title = "Tasks"
    self.view.backgroundColor = .systemBackground
    self.view.addSubview(tableView)
    view.addSubview(activityIndicator)
    navigationItem.rightBarButtonItem = btnAdd
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
    ])
  }
  
  @objc func presentEntryViewController() {
    presentor?.startLoadingEnterTaskScreen() {
      self.presentor?.startFetchingToDos()  // fetch the list again, and it will be updated
    }
  }
}

extension TasksViewController: LocalPresenterToViewProtocol {
  func showTasks(tasksArray: [TaskViewModel]) {
    print("Tasks: \(String(describing: tasksArray))")
    tasks = tasksArray
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.hideProgressIndicator()
    }
  }
  
  func showError() {
    debugPrint("Error")
    hideProgressIndicator()
  }
  
  private func showProgressIndicator() {
    activityIndicator.startAnimating()
  }
  
  private func hideProgressIndicator() { 
    activityIndicator.stopAnimating()
  }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
    cell?.configure(taskName: tasks[indexPath.row].name, isChecked: tasks[indexPath.row].isComplete)
    cell?.delegate = self
    return cell!
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let taskToDelete = tasks[indexPath.row]
      presentor?.deleteItemRequested(taskToDeleteId: taskToDelete.name)
      tasks.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}

extension TasksViewController: TaskCellDelegate {
  func taskCell(_ cell: TaskCell, didChangeCheckboxState: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let task = tasks[indexPath.row]
    presentor?.toggleTaskIsCompleteRequest(taskToToggleId: task.name, isComplete: didChangeCheckboxState)
  }
}
