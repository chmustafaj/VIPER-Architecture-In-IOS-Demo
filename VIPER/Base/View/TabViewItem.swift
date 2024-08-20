//
//  TabViewItem.swift
//  ProgrammaticUI2
//
//  Created by Mustafa Jawad on 7/19/24.
//

import Foundation
import UIKit

class TabViewItem: UIView {
  private var label: String
  private var image: UIImage
  private let normalColor: UIColor = .systemGray
  private let selectedColor: UIColor = .black
  lazy var imageView : UIImageView = {
    let v = UIImageView()
    v.image = self.image
    v.translatesAutoresizingMaskIntoConstraints = false
    v.tintColor = normalColor
    return v
  }()
  lazy var titleLabel : UILabel = {
    let l = UILabel()
    l.text = self.label
    l.textColor = normalColor
    l.translatesAutoresizingMaskIntoConstraints = false
    return l
    
  }()
  var isSelected: Bool = false {
    didSet {
      titleLabel.textColor = isSelected ? selectedColor : normalColor
      imageView.tintColor = isSelected ? selectedColor : normalColor
    }
  }
  init(label: String, image: UIImage) {
    self.label = label
    self.image = image
    super.init(frame: .zero)
    setUpViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpViews() {
    
    addSubview(imageView)
    
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 25),
      imageView.widthAnchor.constraint(equalToConstant: 30),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -30),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
}
