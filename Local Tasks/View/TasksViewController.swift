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
  private let listId: String?
  
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
  
  init(models: [Group] = [Group](), listId: String?) {
    self.listId = listId
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupUI()
    self.title = "Tasks"
    
    presentor?.startFetchingToDos(selectedListId: listId!)
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
    let entryVC = LocalRouter.createEntryModule(listToAddTaskToId: listId!)
    entryVC.update = {
      self.presentor?.startFetchingToDos(selectedListId: self.listId!)
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    let navController = UINavigationController(rootViewController: entryVC)
    navController.modalPresentationStyle = .fullScreen
    present(navController, animated: true, completion: nil)
  }
  
  
}

extension TasksViewController: LocalPresenterToViewProtocol {
  
  func showTasks(tasksArray: [TaskViewModel]) {
    print("List: \(String(describing: listId))")
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

extension TasksViewController: UITableViewDelegate, UITableViewDataSource, TaskCellDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
    cell!.label.text = tasks[indexPath.row].name
    cell!.checkBox.isChecked = tasks[indexPath.row].isComplete
    cell!.delegate = self
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
  
  func taskCell(_ cell: TaskCell, didChangeCheckboxState: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let task = tasks[indexPath.row]
    presentor?.toggleTaskIsCompleteRequest(taskToToggleId: task.name, isComplete: didChangeCheckboxState)
  }
  
}
