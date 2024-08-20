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
  var presenter: EnterTaskViewToPresenterProtocol?
  // MARK: - UI Elements
  
  private let field: UITextField = {
    let field = UITextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    field.layer.borderWidth = 1.0
    field.layer.borderColor = UIColor(white: 0.5, alpha: 0.3).cgColor
    return field
  }()
  
  private lazy var btnSave: UIBarButtonItem = {
    let btn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
    return btn
  }()
  
  // MARK: - Lifecycle
  init(update: (() -> Void)? = nil) {
    self.update = update
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: - Methods
  private func setupUI() {
    self.title = "Add Task to list"
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
  
  @objc func saveTask() {
    guard let text = field.text, !text.isEmpty else {
      return
    }
    presenter?.startAddingTaskToList(taskName: text)
    self.navigationController?.popViewController(animated: true)
  }
}

extension EntryViewController: EnterTaskPresenterToViewProtocol {
  func showTaskAdded() {
    update?()
  }
  
  func showError() {
    debugPrint("error adding")
  }
}
