//
//  ViewController.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import UIKit


class HomeViewController: UIViewController {
  // MARK: - Variables
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  private var models = [Group]()
  
  // Delegate
  weak var delegate: ListViewDelegate?
  
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
    getAllItems()
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
  
  private func getAllItems() {
    do {
      print("Getting data")
      models = try context.fetch(Group.fetchRequest())
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    } catch {
      print("Cannot get data")
    }
  }
  
  private func deleteItem(item: Group) {
    context.delete(item)
    do {
      try context.save()
    } catch {
      print("Error saving")
    }
  }
  
  // ListViewDelegate method
  func updateListView(items: [Group]) {
    self.models = items
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedList = models[indexPath.row]
    let tasksVC = LocalRouter.createModule(selectedGroup: selectedList)
     navigationController?.pushViewController(tasksVC, animated: true)

  }
}
