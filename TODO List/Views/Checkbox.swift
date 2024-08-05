//
//  CheckBox.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//

import UIKit

class Checkbox: UIButton {
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            self.updateImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        self.updateImage()
    }
    
    @objc private func toggleCheck() {
        isChecked.toggle()
    }
    
    private func updateImage() {
        let image = isChecked ? checkedImage : uncheckedImage
        self.setImage(image, for: .normal)
    }
}
