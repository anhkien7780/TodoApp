//
//  CheckboxButton.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class CheckboxButton: UIButton{
    
    var isChecked: Bool = false{
        didSet {
            updateImage()
        }
    }
    var onCheckChange : ((Bool) -> Void)?
    
    init(isChecked: Bool){
        super.init(frame: .zero)
        self.isChecked = isChecked
        updateImage()
        self.addTarget(self, action: #selector(toggleChecked), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func toggleChecked() {
        isChecked.toggle()
        onCheckChange?(isChecked)
    }
    
    private func updateImage() {
        let imageName = isChecked ? "Checked=True" : "Checked=False"
        setImage(UIImage(named: imageName), for: .normal)
    }
}
