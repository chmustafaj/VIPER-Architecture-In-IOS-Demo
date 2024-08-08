//
//  TabView.swift
//  ProgrammaticUI2
//
//  Created by Mustafa Jawad on 7/19/24.
//

import UIKit

protocol TabViewDelegate: AnyObject {
  func tabView(_ tabView: TabView, didSelectItemAt index: Int)
}

class TabView: UIView {
  private let item1: TabViewItem
  private let item2: TabViewItem
  weak var delegate: TabViewDelegate?
  
  init(item1: TabViewItem, item2: TabViewItem) {
    self.item1 = item1
    self.item2 = item2
    super.init(frame: .zero)
    setUpViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpViews() {
    item1.translatesAutoresizingMaskIntoConstraints = false
    item2.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(item1)
    addSubview(item2)
    item1.isSelected = true
    
    NSLayoutConstraint.activate([
      item1.leadingAnchor.constraint(equalTo: leadingAnchor),
      item1.topAnchor.constraint(equalTo: topAnchor),
      item1.bottomAnchor.constraint(equalTo: bottomAnchor),
      item1.widthAnchor.constraint(equalTo: item2.widthAnchor),
      
      item2.leadingAnchor.constraint(equalTo: item1.trailingAnchor),
      item2.topAnchor.constraint(equalTo: topAnchor),
      item2.bottomAnchor.constraint(equalTo: bottomAnchor),
      item2.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
    
    item1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(item1Tapped)))
    item2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(item2Tapped)))
  }
 
  @objc private func item1Tapped() {
    print("Item 1 ")
    item1.isSelected = true
    item2.isSelected = false
    delegate?.tabView(self, didSelectItemAt: 0)
  }
  
  @objc private func item2Tapped() {
    print("item 2")
    item1.isSelected = false
    item2.isSelected = true
    delegate?.tabView(self, didSelectItemAt: 1)
  }
}

