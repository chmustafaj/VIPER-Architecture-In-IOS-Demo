//
//  ViewController.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import UIKit

class HomeViewController: UIViewController {
  //MARK: - Variables
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  private var models = [Task]()
  
  // MARK: - UI Elements
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
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupTableView()
    getAllItems()
  }
  
  // MARK: - Methods
  private func setupUI() {
    self.title = "Tasks"
    self.view.backgroundColor = .systemBackground
    self.view.addSubview(tableView)
    navigationItem.rightBarButtonItem = btnAdd
    
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
 
  @objc func presentEntryViewController() {
    let entryVC = EntryViewController()
    entryVC.update = {
      self.getAllItems()
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    let navController = UINavigationController(rootViewController: entryVC)
    navController.modalPresentationStyle = .fullScreen
    present(navController, animated: true, completion: nil)
  }
  
  private func getAllItems() {
    do{
      print("getting data")
      models = try context.fetch(Task.fetchRequest())
      DispatchQueue.main.async {
        self.tableView.reloadData()
        
      }
    }
    catch {
      print("Cannot get data")
    }
  }
  
  private func deleteItem(item: Task) {
    context.delete(item)
    do{
      try context.save()
    }
    catch {
      print("error saving")
    }
    
  }
}


// MARK: - Delegate Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
    cell!.label.text = models[indexPath.row].name
    return cell!
  }
  
  
}
