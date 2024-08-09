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
  private var listId: String?
  private var presenter: EnterTaskViewToPresenterProtocol?
  // MARK: - UI Elements
  
  private let field: UITextField = {
    let f = UITextField()
    f.translatesAutoresizingMaskIntoConstraints = false
    f.layer.borderWidth = 1.0
    f.layer.borderColor = UIColor(white: 0.5, alpha: 0.3).cgColor
    return f
  }()
  
  private let btnClose = {
    let btn = UIButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setImage(UIImage(systemName: "xmark"), for: .normal)
    btn.addTarget(EntryViewController.self, action: #selector(closeScreen), for: .touchUpInside)
    return btn
  }()
  
  private lazy var btnSave: UIBarButtonItem = {
    let btn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
    return btn
  }()
  
  // MARK: - Lifecycle
  init(update: (() -> Void)? = nil, listToAddTaskToId: String) {
    self.update = update
    self.listId = listToAddTaskToId
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    field.delegate.self
    
  }
  
  // MARK: - Methods
  private func setupUI() {
    self.title = "Add Task to list"
    view.backgroundColor = .systemBackground
    self.view.addSubview(field)
    self.view.addSubview(btnClose)
    navigationItem.rightBarButtonItem = btnSave
    
    NSLayoutConstraint.activate([
      field.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      field.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      field.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      field.heightAnchor.constraint(equalToConstant: 52),
      
      btnClose.heightAnchor.constraint(equalToConstant: 20),
      btnClose.widthAnchor.constraint(equalToConstant: 20),
      btnClose.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      btnClose.topAnchor.constraint(equalTo: view.topAnchor, constant: 90 )
      
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
    presenter?.startAddingTaskToList(listId: listId!, taskName: text)
  }
  
  @objc func closeScreen() {
    dismiss(animated: true)
  }
}

extension EntryViewController: EnterTaskPresenterToViewProtocol {
  func showTaskAdded() {
    update?()
    dismiss(animated: true)
  }
  
  func showError() {
    debugPrint("error adding")
  }
  
  
}
