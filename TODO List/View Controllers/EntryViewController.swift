//
//  EntryViewController.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import UIKit

class EntryViewController: UIViewController {
  // MARK: - Variables
  var update: (() -> Void)?
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  // MARK: - UI Elements
  private let field: UITextField = {
    let f = UITextField()
    f.translatesAutoresizingMaskIntoConstraints = false
    f.layer.borderWidth = 1.0
    f.layer.borderColor = UIColor(white: 0.5, alpha: 0.3).cgColor
    f.layer.shadowOpacity = 1
    f.layer.shadowRadius = 4.0
    f.layer.shadowColor = UIColor.black.cgColor
    return f
  }()
  
  private lazy var btnSave: UIBarButtonItem = {
    let btn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
    return btn
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    field.delegate.self
    
  }
  
  // MARK: - Methods
  private func setupUI() {
    view.backgroundColor = .systemBackground
    self.view.addSubview(field)
    navigationItem.rightBarButtonItem = btnSave
    
    NSLayoutConstraint.activate([
      field.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      field.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      field.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      field.heightAnchor.constraint(equalToConstant: 52)
      
    ])
  }
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    saveTask()
    return true
  }
  
  @objc func saveTask() {
    guard let text = field.text, !text.isEmpty else {
      return
    }
    let newItem = Task(context: context)
    newItem.name = text
    newItem.createdAt = Date()
    do{
      print("Saving")
      try context.save()
    }
    catch {
      print("error saving")
    }
    update?()
    dismiss(animated: true)
    
  }
  
  
  private func updateItem(item: Task, newName: String) {
    item.name = newName
    item.createdAt = Date()
    do{
      try context.save()
    }
    catch {
      print("error saving")
    }
  }
}
