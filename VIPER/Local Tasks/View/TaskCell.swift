//
//  TaskCell.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import Foundation
import UIKit

protocol TaskCellDelegate: AnyObject {
  func taskCell(_ cell: TaskCell, didChangeCheckboxState: Bool)
}

class TaskCell: UITableViewCell {
  static let identifier = "TaskCell"
  weak var delegate: TaskCellDelegate?
  
  let label: UILabel = {
    let l = UILabel()
    l.translatesAutoresizingMaskIntoConstraints = false
    return l
  }()
  
  let checkBox: Checkbox = {
    let c = Checkbox()
    c.translatesAutoresizingMaskIntoConstraints = false
    return c
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.contentView.addSubview(label)
    self.contentView.addSubview(checkBox)
    checkBox.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
    
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
      label.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: checkBox.leadingAnchor, constant: -20),
      label.heightAnchor.constraint(equalToConstant: 20),
      
      checkBox.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
      checkBox.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
      checkBox.widthAnchor.constraint(equalToConstant: 20),
      checkBox.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor, constant: -20)
      
      
      
    ])
  }
  @objc private func didTapCheckbox() {
    delegate?.taskCell(self, didChangeCheckboxState: checkBox.isChecked)
  }
  
  func configure(taskName: String, isChecked: Bool) {
    label.text = taskName
    checkBox.isChecked = isChecked
  }
}
