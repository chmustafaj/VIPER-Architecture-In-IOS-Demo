//
//  ViewController.swift
//  ProgrammaticUI2
//
//  Created by Mustafa Jawad on 7/19/24.
//

import UIKit


class BaseViewController: UIViewController, TabViewDelegate, ListViewDelegate {
  
  // MARK: - UI Elements
  private lazy var btnAdd: UIBarButtonItem = {
    let btn = UIBarButtonItem(title: "Create list", style: .plain, target: self, action: #selector(didTapAdd))
    return btn
  }()
  
  private lazy var item1: TabViewItem = {
    let i = TabViewItem(label: "Local", image: UIImage(systemName: "externaldrive.connected.to.line.below")!)
    return i
  }()
  
  private lazy var item2: TabViewItem = {
    let i = TabViewItem(label: "Cloud", image: UIImage(systemName: "icloud")!)
    return i
  }()
  
  private lazy var tabView: TabView = {
    let t = TabView(item1: item1, item2: item2)
    return t
  }()
  
  // MARK: - Variables
  private var models = [Group]()
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  private let homeViewController = HomeViewController()
  private let cloudViewController = CloudViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    homeViewController.delegate = self // Set the delegate here
  }
  
  // MARK: - Methods
  func setupViews() {
    navigationItem.rightBarButtonItem = btnAdd
    tabView.translatesAutoresizingMaskIntoConstraints = false
    tabView.delegate = self
    
    view.addSubview(tabView)
    view.backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tabView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30),
      tabView.heightAnchor.constraint(equalToConstant: 100),
    ])
    
    displayViewController(homeViewController)
  }
  
  private func displayViewController(_ viewController: UIViewController) {
    children.forEach { $0.view.removeFromSuperview() }
    children.forEach { $0.removeFromParent() }
    
    addChild(viewController)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(viewController.view)
    
    NSLayoutConstraint.activate([
      viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      viewController.view.bottomAnchor.constraint(equalTo: tabView.topAnchor)
    ])
    
    viewController.didMove(toParent: self)
  }
  
  func tabView(_ tabView: TabView, didSelectItemAt index: Int) {
    switch index {
    case 0:
      displayViewController(homeViewController)
    case 1:
      displayViewController(cloudViewController)
    default:
      break
    }
  }
  
  @objc func didTapAdd() {
    let alert = UIAlertController(title: "New List", message: "Enter new list", preferredStyle: .alert)
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { _ in
      guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
        return
      }
      self.createList(name: text)
    }))
    present(alert, animated: true)
  }
  
  private func createList(name: String) {
    let newItem = Group(context: context)
    newItem.name = name
    do {
      print("Saving")
      try context.save()
    } catch {
      print("Error saving")
    }
    
    do {
      print("Getting data")
      models = try context.fetch(Group.fetchRequest())
      updateListView(items: models) 
    } catch {
      print("Cannot get data")
    }
  }
  
  func updateListView(items: [Group]) {
    homeViewController.updateListView(items: items)
  }
}

protocol ListViewDelegate: AnyObject {
  func updateListView(items: [Group])
}
