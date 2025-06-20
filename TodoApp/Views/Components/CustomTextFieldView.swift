//
//  CustomTextFieldView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit

class CustomTextFieldView: UIView {
    
    private let label = UILabel()
    let textField = UITextField()
    private let suffixIconView = UIImageView()
    
    init(labelText: String, placeholder: String, suffixIcon: UIImage? = nil, textFieldHeight: CGFloat? = nil) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        
        label.text = labelText
        textField.placeholder = placeholder
        if let icon = suffixIcon {
            setSuffixIcon(icon)
        }
        if let heightConstant = textFieldHeight {
            setTextFieldHeight(height: heightConstant)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.rightViewMode = .always
        
        suffixIconView.contentMode = .scaleAspectFit
        suffixIconView.tintColor = .gray
        suffixIconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    }
    
    private func setupConstraints() {
        addSubview(label)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setSuffixIcon(_ image: UIImage) {
        suffixIconView.image = image
        suffixIconView.contentMode = .scaleAspectFit

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))

        // Đặt frame icon (căn giữa trong container)
        let iconSize: CGFloat = 20
        let padding: CGFloat = (36 - iconSize) / 2
        suffixIconView.frame = CGRect(x: padding, y: padding, width: iconSize, height: iconSize)

        container.addSubview(suffixIconView)
        textField.rightView = container
        textField.rightViewMode = .always
    }
    
    func setTextFieldHeight(height: CGFloat){
        textField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

