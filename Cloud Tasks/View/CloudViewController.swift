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
  private var todos = [Todo]()
  // MARK: - UI Elements
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
    getTodos()
    setupUI()
    setupTableView()
    
  }
  
  // MARK: - Methods
  func setupUI() {
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
  
  func getTodos() {
    NetworkingClient.shared.fetchTodos { [weak self] result in
      switch result {
      case .success(let todos):
        self?.todos = todos
        print(todos)
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      case .failure(let error):
        print("Failed to fetch todos:", error)
      }
    }
  }
  
  func updateTodoCompletion(todo: Todo, completion: @escaping (Result<Todo, Error>) -> Void) {
    let url = "https://dummyjson.com/todos/\(todo.id)"
    let parameters: [String: Any] = [
      "completed": todo.completed
    ]
    
    AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default)
      .responseDecodable(of: Todo.self) { response in
        switch response.result {
        case .success(let updatedTodo):
          completion(.success(updatedTodo))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  
}

extension CloudViewController: UITableViewDelegate, UITableViewDataSource, TaskCellDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
    cell!.label.text = todos[indexPath.row].todo
    cell!.checkBox.isChecked = todos[indexPath.row].completed
    cell!.delegate = self
    return cell!
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let taskToDelete = todos[indexPath.row]
      //deleteItem(item: taskToDelete)
      todos.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func taskCell(_ cell: TaskCell, didChangeCheckboxState: Bool) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    var task = todos[indexPath.row]
    task.completed = didChangeCheckboxState
    updateTodoCompletion(todo: task) { result in
      switch result {
      case .success(let updatedTodo):
        print("Updated Todo: \(updatedTodo)")
      case .failure(let error):
        print("Failed to update Todo: \(error.localizedDescription)")
      }
    }
  }
}
