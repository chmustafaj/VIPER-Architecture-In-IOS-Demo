//
//  TasksViewController.swift
//  TODO List
//
//  Created by Mustafa Jawad on 7/8/2024.
//

import UIKit

class TasksViewController: UIViewController {
  
  var presentor:ViewToPresenterProtocol?
  // MARK: - Variables
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  private var tasks = [Task]()
  let list: Group?
  
  // MARK: - UI Elements
  private let tableView: UITableView = {
    let tb = UITableView()
    tb.backgroundColor = .systemBackground
    tb.allowsSelection = true
    tb.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
    tb.translatesAutoresizingMaskIntoConstraints = false
    return tb
  }()
  // TODO:
//  private lazy var btnAdd: UIBarButtonItem = {
//    let btn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(presentEntryViewController))
//    return btn
//  }()
  var tasksArrayList:Array<Task> = Array()
  
  init(models: [Group] = [Group](), list: Group?) {
    // self.models = models
    self.list = list
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
    presentor?.startFetchingToDos()
    //showProgressIndicator(view: self.view)
    
    //        uiTableView.delegate = self
    //        uiTableView.dataSource = self
    
  }
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  private func setupUI() {
    self.title = "Tasks"
    self.view.backgroundColor = .systemBackground
    self.view.addSubview(tableView)
    // TODO: 
    //navigationItem.rightBarButtonItem = btnAdd
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
      
    ])
  }
  
//    private func deleteItem(item: Task) {
//      context.delete(item)
//      do{
//        try context.save()
//      }
//      catch {
//        print("error saving")
//      }
//  
//    }
  
  //  @objc func presentEntryViewController() {
  //    let entryVC = EntryViewController(list: list!)
  //    entryVC.update = {
  //      self.getAllItems()
  //      DispatchQueue.main.async {
  //        self.tableView.reloadData()
  //      }
  //    }
  //    let navController = UINavigationController(rootViewController: entryVC)
  //    navController.modalPresentationStyle = .fullScreen
  //    present(navController, animated: true, completion: nil)
  //  }
}

extension TasksViewController:PresenterToViewProtocol{
  func showTasks(tasksArray: Array<Task>) {
    tasks = tasksArray.filter({ $0.group == list})
    
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
      
    }
  }
  
  func showError() {
    debugPrint("Error")
   // hideProgressIndicator(view: self.view)
//    let alert = UIAlertController(title: "Alert", message: "Problem Fetching Tasks", preferredStyle: UIAlertControllerStyle.alert)
//    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
//    self.present(alert, animated: true, completion: nil)
    
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
  // TODO: Add delete feature
//  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//      let taskToDelete = tasks[indexPath.row]
//      deleteItem(item: taskToDelete)
//      tasks.remove(at: indexPath.row)
//      tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
//  }
  
  func taskCell(_ cell: TaskCell, didChangeCheckboxState: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let task = tasks[indexPath.row]
    task.isComplete = didChangeCheckboxState
    do {
      try context.save()
    } catch {
      print("Failed to save task")
    }
  }
  
}
